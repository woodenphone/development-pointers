/* enable-compression.template.sql
 * Enable compression for a table, wrapped in diagnostic statements.
 * 
 * ======================================== *
 * Example templating from this file:
 *   $ sed "s/qa_images/${table}/g" < enable-compression.template.sql > enable-compression.table-name.sql
 * All replacement placeholders follow the convention %%FOO%% for easy replacement.
 * ======================================== *
 * LICENSE: BSD0
 * AUTHOR: Ctrl-S
 * CREATED: 2023-04-08
 * MODIFIED: 2023-04-09
 * ======================================== *
 */
select 'Start of SQL script' AS '';

/* =====< Pre-op stats >===== */
select 'Showing engine status' AS '';
SHOW ENGINE INNODB STATUS;

/* https://mariadb.com/kb/en/show-table-status/ */
select 'Showing tables status' AS '';
SHOW TABLE STATUS;

SELECT table_schema "database", sum(data_length + index_length)/1024/1024/1024 "size in GB" FROM information_schema.TABLES GROUP BY table_schema;
/* =====< /Pre-op stats >===== */


select concat ("Before operation, UTC_TIMESTAMP() is ", UTC_TIMESTAMP(), " and UNIX_TIMESTAMP() is ", UNIX_TIMESTAMP() ) as '';
/* =====< Perform actual operation >===== */

/*
 * See docs RE: 'ROW FORMAT='
 *   https://mariadb.com/kb/en/innodb-online-ddl-operations-with-the-inplace-alter-algorithm/
 *
 *   https://mariadb.com/kb/en/innodb-page-compression/
 */
ALTER TABLE `qa_images` ROW_FORMAT=COMPRESSED;

/* =====< /Perform actual operation >===== */
select concat ("Finished operation, UTC_TIMESTAMP() is ", UTC_TIMESTAMP(), " and UNIX_TIMESTAMP() is ", UNIX_TIMESTAMP() ) as '';


/* =====< Post-op stats >===== */
select 'Showing tables status' AS '';
SHOW TABLE STATUS;

SELECT table_schema "database", sum(data_length + index_length)/1024/1024/1024 "size in GB" FROM information_schema.TABLES GROUP BY table_schema;
/* =====< /Post-op stats >===== */


/* End of SQL script. */
select 'End of SQL script' AS '';
