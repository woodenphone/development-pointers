# opens RPA files created with renpy
# extracts contents of RPA files
# lists contents of RPA files

# https://github.com/renpy/renpy/blob/9c71146079cdc8ea20327ed7ce791325b287f54a/launcher/game/archiver.rpy
# "These files are really easy to reverse-engineer, but are probably better than nothing."
# well i mean. the source code for compressing is literally online under MIT license. so yes. it's trivial. -deka

# RPA EXTRACTOR
# RPA files are archives used by RenPy. They are often used to distribute assets for the game.
# They are pretty much just compressed pickled files with an offset index at the end of the file.
# Each file entry is prefixed with the text "Made with Ren'Py." followed by the uncompressed (?)
# contents of the file (not sure at this time why the INDEX is compressed but the files are not;
# maybe the authors were going for a TAR-like layout?)
#
# The index is weird in that it uses a "key" to XOR all of its entries with, though I am an unsure
# deka when it comes to the reasons why; this key is written out to the file and can be read by anybody,
# and appears to always be the same. Oh well!

# THIS SCRIPT IS QUICK AND DIRTY; FUNCTIONS OFTEN USE sys.exit AS THEIR FAILURE MODE

# Copyright (c) 2021 Rebecca Nelson
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import sys
import pickle
import zlib
import os.path

PADDING_BYTES = b"Made with Ren'Py."

def fatal(msg):
	print(msg, file=sys.stderr)
	sys.exit(1)

def read_entries(filename):
	"""
	Read the entry data from the given RPA file.
	
	This will be the file index, converted to table for readability.
	It is a map where each key is a path of a file in the archive and each 
	value is a table that includes the offset within the archive as well as
	the length of the data. The offset does not include the "padding" entry header,
	"Made with Ren'Py.".
	"""
	with open(filename, 'rb') as f:
		magic_header_bytes = f.read(7)
		if len(magic_header_bytes) < 7:
			fatal("bad magic header; only got " + str(len(magic_header_bytes)) + " bytes but expected 7")
		magic_header = magic_header_bytes.decode("utf-8")
		if magic_header != "RPA-3.0":
			fatal("bad magic header; expected \"RPA-3.0\" in first 7 bytes but was: " + str(magic_header))
		
		# space between preamble magic number and index offset. consume.
		b = f.read(1)
		if len(b) < 1:
			fatal("no more file available while reading header, expected space after preamble but got no bytes")
		
		index_off_bytes = f.read(16)
		if len(index_off_bytes) < 16:
			fatal("bad index offset; only got " + str(len(index_off_bytes)) + " bytes but expected 16")
		index_offset = int(index_off_bytes.decode("utf-8"), 16)
		if index_offset <= 0:
			fatal("nonsensical index offset: " + str(index_offset))
		
		# space between index offset and key. consume.
		b = f.read(1)
		if len(b) < 1:
			fatal("no more file available while reading header, expected space after index offset but got no bytes")
			
		key_bytes = f.read(8)
		if len(key_bytes) < 8:
			fatal("bad file key; only got " + str(len(key_bytes)) + " bytes but expected 8")
			
		key = int(key_bytes.decode("utf-8"), 16)
		
		# we now have a key and index offset. read the index
		f.seek(index_offset)
		raw_index = pickle.loads(zlib.decompress(f.read()))
		
	# decode XOR'd entries and turn into more readable version
	index = decode_raw_index(raw_index, key)
	return index
	
def decode_raw_index(index, key):
	# i seriously do not know what purpose key could possibly serve in an RPA archive.
	# encryption? it seems like it, but like. XORing is a TERRIBLE encryption algo
	# and also the key is always present with file. i cant see any reason for it to
	# exist as of today (1/26/2021) except to use up cpu cycles.
	#
	# maybe pytom wanted to extend functionality to proper encryption later?
	# or it's just an artifact from way back when or something, idk.
	
	new_index = dict()
	for k in index:
		if len(index[k]) > 1:
			fatal("index has multiple entries for item: " + repr(k) + " -> " + repr(index[k]))
		if len(index[k]) < 1:
			fatal("index has no entries for item: " + repr(k) + " -> []")
		if len(index[k][0][2]) != 0:
			fatal("index has non-empty terminator for item: " + repr(k) + " -> " + repr(index[k]))
		new_index[k] = {'offset': index[k][0][0] ^ key, 'size': index[k][0][1] ^ key}
	return new_index
		
def list_contents(filename):
	index = read_entries(filename)
	items = []
	for k in index:
		items.append(k)
	
	for i in sorted(items):
		print(i)
		
def print_entry_info(filename, entry_name):
	index = read_entries(filename)
	if entry_name not in index:
		fatal(repr(entry_name) + " is not in the RPA file " + repr(filename) + "\nuse `list` command to see full list")
	print(repr(entry_name) + " in " + repr(filename) + ":")
	print("Size:   " + str(index[entry_name]['size']) + " byte" + ("s" if index[entry_name]['size'] != 1 else ""))
	print("Offset: 0x%016x" % (index[entry_name]['offset'],))
	
def extract_entry(filename, entry_name, destination):
	index = read_entries(filename)
	if entry_name not in index:
		fatal(repr(entry_name) + " is not in the RPA file " + repr(filename) + "\nuse `list` command to see full list")
	offset, size = index[entry_name]['offset'], index[entry_name]['size']
	
	with open(filename, 'rb') as f:
		f.seek(offset - len(PADDING_BYTES))
		padding_data = f.read(len(PADDING_BYTES))
		if padding_data != PADDING_BYTES:
			fatal("entry is not preceeded by PADDING_BYTES; are you sure this is a RPA v3 archive?")
		data = f.read(size)
	if len(data) != size:
		fatal("expected an entry of size %d but only read %d before EOF" % (size, len(data)))
	with open(destination, 'wb') as f:
		f.write(data)
		
def _split_path_components(path):
	comps = []
	while len(path) != 0:
		path, comp = os.path.split(path)
		if comp != "":
			comps.append(comp)
	return list(reversed(comps))
	
		
def extract_all(filename, destination):
	index = read_entries(filename)
	try:
		os.mkdir(destination)
	except FileExistsError:
		# no reason to fail; we dont need to overwrite existing files
		pass
	with open(filename, 'rb') as f:
		for name, entry in index.items():
		
			path_components = _split_path_components(name)
			
			# walk the tree and make dirs to hold the file:
			dest_path = destination
			for comp in path_components[:-1]:
				dest_path = os.path.join(dest_path, comp)
				try:
					os.mkdir(os.path.join(dest_path))
				except FileExistsError:
					# no reason to deal with this, we just dont need that dir.
					pass
		
			file_dest = os.path.join(dest_path, path_components[-1])
			
			offset, size = entry['offset'], entry['size']
			f.seek(offset - len(PADDING_BYTES))
			padding_data = f.read(len(PADDING_BYTES))
			if padding_data != PADDING_BYTES:
				fatal("entry is not preceeded by PADDING_BYTES; are you sure this is a RPA v3 archive?")
			data = f.read(size)
			if len(data) != size:
				fatal("expected an entry of size %d but only read %d before EOF" % (size, len(data)))
			with open(file_dest, 'wb') as extracted_file:
				extracted_file.write(data)	

	
if __name__ == "__main__":
	own_name = os.path.basename(sys.argv[0])
	help_msg = ""
	help_msg += "usage: %s list|t RPA_FILE\n"
	help_msg += "       %s info|i RPA_FILE ENTRY\n"
	help_msg += "       %s get|g RPA_FILE ENTRY DEST\n"
	help_msg += "       %s extract|x RPA_FILE DEST"
	usage_msg = help_msg % (own_name, own_name, own_name, own_name)
	if len(sys.argv) < 2:
		fatal(usage_msg)
		
	command = sys.argv[1]
	if command == 't':
		command = 'list'
	elif command == 'i':
		command = 'info'
	elif command == 'g':
		command = 'get'
	elif command == 'x':
		command = 'extract'
	
	if command == 'list':
		if len(sys.argv) < 3:
			fatal(usage_msg + "\n\n`list` command requires filename of RPA archive")
		rpa_file = sys.argv[2]
		list_contents(rpa_file)
	elif command == 'info':
		if len(sys.argv) < 3:
			fatal(usage_msg + "\n\n`info` command requires filename of RPA archive")
		if len(sys.argv) < 4:
			fatal(usage_msg + "\n\n`info` command requires entry to get info on")
		rpa_file = sys.argv[2]
		entry = sys.argv[3]
		print_entry_info(rpa_file, entry)
	elif command == 'get':
		if len(sys.argv) < 3:
			fatal(usage_msg + "\n\n`get` command requires filename of RPA archive")
		if len(sys.argv) < 4:
			fatal(usage_msg + "\n\n`get` command requires entry to be extracted")
		if len(sys.argv) < 5:
			fatal(usage_msg + "\n\n`get` command requires destination file")
		rpa_file = sys.argv[2]
		entry = sys.argv[3]
		dest = sys.argv[4]
		extract_entry(rpa_file, entry, dest)
	elif command == 'extract':
		if len(sys.argv) < 3:
			fatal(usage_msg + "\n\n`extract` command requires filename of RPA archive")
		if len(sys.argv) < 4:
			fatal(usage_msg + "\n\n`extract` command requires destination directory")
		rpa_file = sys.argv[2]
		dest = sys.argv[3]
		extract_all(rpa_file, dest)
	else:
		fatal(usage_msg + "\n\nunknown command %s. Must be one of the above or the short variants t, i, g, or x.")
