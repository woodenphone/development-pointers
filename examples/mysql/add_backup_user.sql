/* add_backup_user.sql
 * Description: Create user for backups.
 * By: Ctrl-S
 * Created: 2020-11-17
 * Updated: 2024-12-15
 */

/* Create backup user */
CREATE USER 'backup'@'localhost' IDENTIFIED BY 'passwordhere';
CREATE USER 'backup'@'example-remote-host' IDENTIFIED BY 'passwordhere';

/* Grant priveleges to backup user */
GRANT SELECT, LOCK TABLES ON *.* to 'backup'@'localhost'; -- plain "$ mysql" command ($USER@localhost)
GRANT SELECT, LOCK TABLES  ON *.* to 'backup'@'example-remote-host'; -- SSH portforwards ($USER@$HOSTNAME)
FLUSH PRIVILEGES;
