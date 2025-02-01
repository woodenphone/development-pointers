#!python3
## hashdeep-tosqlite.py
## AUTHOR: Ctrl-S
## CREATED: 2021-11-26
## imports: STDLIB 
import sqlite3
import logging
import os
import re
from contextlib import closing ## https://www.digitalocean.com/community/tutorials/how-to-use-the-sqlite3-module-in-python-3


## Constants
HASHLIST_FILE =  os.path.join('foo.hashlist')
DB_FILE = os.path.join('hashes.sqlite')
TABLENAME = 'hashdeep'



def mk_create_stmt(columns):
	## e.g. '%%%% size,md5,sha1,sha256,tiger,whirlpool,filename'
	## cursor.execute("CREATE TABLE fish (name TEXT, species TEXT, tank_number INTEGER)")
	stmt_create_template = """CREATE TABLE 'hashdeep' ({fields})"""
	fields = ''
	for column in columns:
		if (column is 'size'):
			fields += 'size INTEGER,'
		else:
			fields += f'{column} TEXT,'
	fields = fields[:-1] # Drop trailing comma
	return stmt_create_template.format(fields=fields)


def mk_insert_stmt(columns):
	## e.g. '%%%% size,md5,sha1,sha256,tiger,whirlpool,filename'
	## cursor.execute("INSERT INTO fish VALUES ('Sammy', 'shark', 1)")
	stmt_insert_template = """INSERT INTO hashdeep VALUES ({fields})"""
	fields = ''
	for column in columns:
		fields += f' ?,'
	fields = fields[:-1] # Drop trailing comma
	return stmt_insert_template.format(fields=fields)


def main():
	logging.basicConfig(level=logging.DEBUG)
	logging.info(f'Logging started')
	
	logging.info(f'Open sqlite3 DB file')
	## https://docs.python.org/3/reference/compound_stmts.html#the-with-statement
	with closing( sqlite3.connect(DB_FILE) ) as connection,\
		closing( connection.cursor() ) as cursor,\
		open(HASHLIST_FILE, 'r') as f_in:
		logging.info(f'Begin processing input file')
		in_header = True # We start in the header.
		ln = 0 # First line is 1.
		for line in f_in:
			ln += 1
			if (ln % 1000 == 0):
				logging.debug(f'Up to line {ln}')
			if in_header: # If we're in the header.
				if ln > 2: # No we aren't.
					logging.info(f'Data starting at ln={ln!r}: {line}')
					in_header = False
					## Flow thorough to data handling code
				elif line.startswith('%%%% HASHDEEP-1.0'):
					print(line)
					continue
				else: # Learn the columns .
					## %%%% size,md5,sha1,sha256,tiger,whirlpool,filename
					assert(line.startswith('%%%%')) # We ought to see this.

					columns = re.findall ('([a-zA-Z0-9]+)', line)
					
					logging.info(f'Generate statements with columns={columns!r}')
					stmt_create = mk_create_stmt(columns)
					stmt_insert = mk_insert_stmt(columns)
					logging.info(f'stmt_create={stmt_create!r}')
					logging.info(f'stmt_insert={stmt_insert!r}')

					logging.info(f'Create table with columns={columns!r}')
					cursor.execute(stmt_create)
					continue
			else: # If we're in the data.
				## ex:'68254,cdf95ac7c381910328740a7e1b70e10d,4de04b088c23d415e0be05e16b41af58cd19a9a2,cb6e0d61c9dc3ea199fa8b027df69a8b51799b05ea43eb8b6531e499163c2baa,3fa3fb095c1690a321e01395bfd41733dbe37a48c4b07b51,2ffb0dd81d144c5c22631d29fae9583de76df57457de4f4890515b5c48f92a0ce44e7c0fb5513d2fd5b000c6339fcb4281f1d388e432d9815f51b9abe49fdbdf,/weedmnt/neofuuka-or-02/media/lit/image/1619/19/1619197217167.jpg'
				row = line.split(',')
				logging.debug(f'row={row!r}')
				cursor.execute(stmt_insert, (columns))
				continue
		nchanges = connection.total_changes
		logging.debug(f'Connection has made {nchanges} changes')
		logging.info(f'Finished processing input file')
	logging.info(f'Exiting')
	return


if __name__ == '__main__':
	main()
