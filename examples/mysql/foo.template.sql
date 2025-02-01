/*
 * foo.template.sql
 * ================================== *
 * SQL query to export rows for a range of posts along with their associated images
 * for some given date range.
 * Expects an asagi-like schema.
 *
 * ================================== *
 * ==== USE OF TEMPLATE ====
 * Generate actual SQL from this template by replacing %%VALUE%% with appropriate values.
 * Example: 
 *   $ sed "s|%%EXAMPLE_VARNAME%%|${example_variable?}|g" query.template.sql > query.sql
 *
 * ================================== *
 * ==== RELEVANT LINKS ====
 * https://dev.mysql.com/doc/refman/8.0/en/select.html
 * https://dev.mysql.com/doc/refman/8.0/en/select-into.html
 * https://dev.mysql.com/doc/refman/8.0/en/expressions.html
 *
 * https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_file
 * https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_secure_file_priv
 * ================================== *
 * LICENSE: GPL3
 * AUTHOR: Ctrl-S
 * CREATED: 2023-07-06
 * MODIFIED: 2023-07-06
 * ================================== *
 */



SELECT 
  /* post table */
  `%%BOARD%%`.`doc_id`,
  `%%BOARD%%`.`media_id`,
  `%%BOARD%%`.`num`,
  `%%BOARD%%`.`subnum`,
  `%%BOARD%%`.`thread_num`,
  `%%BOARD%%`.`op`,
  `%%BOARD%%`.`timestamp`,
  `%%BOARD%%`.`timestamp_expired`,
  `%%BOARD%%`.`preview_orig`,
  `%%BOARD%%`.`preview_w`,
  `%%BOARD%%`.`preview_h`,
  `%%BOARD%%`.`media_filename`,
  `%%BOARD%%`.`media_w`,
  `%%BOARD%%`.`media_h`,
  `%%BOARD%%`.`media_size`,
  `%%BOARD%%`.`media_hash`,
  `%%BOARD%%`.`media_orig`,
  `%%BOARD%%`.`spoiler`,
  `%%BOARD%%`.`deleted`,
  `%%BOARD%%`.`capcode`,
  `%%BOARD%%`.`email`,
  `%%BOARD%%`.`name`,
  `%%BOARD%%`.`trip`,
  `%%BOARD%%`.`title`,
  `%%BOARD%%`.`comment`,
  `%%BOARD%%`.`sticky`,
  `%%BOARD%%`.`locked`,
  `%%BOARD%%`.`poster_hash`,
  `%%BOARD%%`.`poster_country`,
  `%%BOARD%%`.`exif`,
  /* images table */
  `%%BOARD%%_images`.`media_id`,
  `%%BOARD%%_images`.`media_hash`,
  `%%BOARD%%_images`.`media`,
  `%%BOARD%%_images`.`preview_op`,
  `%%BOARD%%_images`.`preview_reply`,
  `%%BOARD%%_images`.`total`,
  `%%BOARD%%_images`.`banned`
FROM `%%BOARD%%`
/* JOIN images referenced by posts. LEFT JOIN to permit absent images. */
LEFT JOIN `%%BOARD%%` ON `%%BOARD%%_images`.`media_id` = `%%BOARD%%`.`media_id`
/*
 * `timestamp` int(10) unsigned NOT NULL,
 */
WHERE 
  `%%BOARD%%`.`timestamp` => %%LOW_TIMESTAMP%%
  AND `%%BOARD%%`.`timestamp` < %%HIGH_TIMESTAMP%%
/* Make output tidier */
ORDER BY `%%BOARD%%`.`doc_id` ASC
/* Write to CSV file with clearly-defined delimiters */
INTO OUTFILE "/tmp/%%BOARD%%.csv"
  FIELDS TERMINATED BY ',' ENCLOSED BY '"', ESCAPED BY '\'
  LINES TERMINATED BY "\n"
;
 