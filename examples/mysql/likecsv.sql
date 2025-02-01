SELECT num, comment
FROM a
WHERE num > 123456
  AND comment LIKE "%pastebin%"
 INTO OUTFILE "/tmp/jobname-here.01.csv"
 FIELDS TERMINATED BY ','
 OPTIONALLY ENCLOSED BY '"'
 LINES TERMINATED BY '\n';