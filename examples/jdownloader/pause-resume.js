/* pause-resume.js
 * Momentarily pause downloads to encourage downloads to begin downloading.
 * AUTHOR: Ctrl-S
 * LICENSE: GPL3
 * CREATED: 2022-09-26
 * MODIFIED: 2022-10-04
 */
setDownloadsPaused(true);/*Pause/Unpause Downloads*/
sleep(750/*milliseconds*/);/*Perform a sleep and wait for x milliseconds*/
setDownloadsPaused(false);/*Pause/Unpause Downloads*/
