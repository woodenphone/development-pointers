/* mlp-imgur-links-2023-aa.sql
 *
 * Purpose:
 *   Find posts with links to imgur.
 * 
 * (Assumes an Asagi-like DB structure.)
 *
 * ================================== *
 * USAGE: 
 *   $ mysql DATABASE < query.sql > results.tab
 * ================================== *
 * License: 0BSD
 * Author: Ctrl-S
 * Created: 2023-04-21
 * Modified: 2023-04-21
 * ================================== *
 */

/* Log time of search */
SELECT UNIX_TIMESTAMP();

/* Perform search */
SELECT `thread_num`, `num`, `timestamp`, `name`, `title`, `comment`
FROM `mlp`
WHERE 
	comment LIKE "%imgur%"
	OR name LIKE "%imgur%"
	OR title LIKE "%imgur%"
;
