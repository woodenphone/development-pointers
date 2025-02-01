/* 
 * modify-column.template.sql
 * Resize the columns in my 4ch archive DB so all tables
 *   have the same size columns.
 * ======================================== *
 * EXAMPLE:
 * $ sed "s/%%VAR_NAME%%/${var_name?}/g" < TEMPLATE.sql > QUERY.sql
 * $ sed "s/%%VARIABLE_NAME%%/${variable_name?}/g" < modify-column.template.sql > "modify-column.${board_name?}.sql"
 *
 * ======================================== *
 * AUTHOR: Ctrl-S
 * CREATED: 2023-07-30
 * MODIFIED: 2023-07-30
 * ======================================== *
 */
ALTER TABLE `%%TABLE_NAME%%` (
MODIFY
	`preview_orig` varchar(50) DEFAULT NULL,
	`media_orig` varchar(50) DEFAULT NULL
);
