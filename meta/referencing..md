# Referncing
Maintaining a bibliography with offline backup of documents, pages, files, etc. such that it can be verified and relied upon that the correct file can be found potentially decades later.

## Formatting

One reference may look like
```markdown
* ["title" - "description"](original_link) <!-- {JSON_BLOB} -->
```

`JSON_BLOB` might look like
```json
{
	"date_retrieved": "ISO_DATE",
	"source_urls": ["http://example.com"],
	"files": [
		{
			"original_filename": "index.htm" // from HTTP headers.
			"original_ctime": "ISO-TIMESTAMP" // from HTTP headers.
			"original_mtime": "ISO-TIMESTAMP" // from HTTP headers.
			"size_bytes": 1024,
			"CRC64sum": "CRC64_HASH_HERE",
			"md5sum": "MD5_HASH_HERE",
			"sha256sum": "SHA256_HASH_HERE",
		}
	]
}
```

---------



### Connecting reference with correct file

An identifier value could be associated with the link to be looked up in some simple database file. e.g. simple .json file or a file of newline-delimited json blobs

Identifier value might be compact representation of the hash or part of the hash.

In the case of a hash collission, detect by URL mismatch? Perhaps put timestamp value in compact representation to ensure no false positives?

Since unix timestamp is a int64 counting seconds and one end of the value is sequential zeroes, those should be truncated when converting the value into the ID format for brevity.

A simple monotonic counter based ID (e.g. SQL `PRIMARY KEY id BIGINT AUTOINCREMENT`) would be nice, except that it is only any use for associative lookup to a DB; requires posession of said DB and knowledge which DB to lookup in; instead of being information directly about the actual document being referenced.
(Even crc32 of a file's contents actually narrows the candidates down to very few possible candidates.)


Payload ideas:
---------
`${crc64}${unixtime_retrieved}`
`${md5sum}${unixtime_retrieved}`
`${sha256sum}${unixtime_retrieved}`
`${unixtime_retrieved}` - Assuming "source_urls" is enough to then lookup specific file.
`base32(md5sum_as_binary[0,32])` 


Ientifier value generation examples:
---------
`${unixtime_retrieved}` -> `1738578340` (unixtime, int64 represented as decimal) -> `1JQ16D4`(base32)

`${crc64}${unixtime_retrieved}` (unint32; int64) -> `0x6292fd23, 0x00000000 0x67A099A4`  -> `6292fd230000000067A099A4` (concatenated) -> `MKJP2IYAAAAAAZ5ATGSA====` (base32)

`${unixtime_retrieved}` -> `1738578340` (unixtime, native int64  represented as decimal) -> `1JQ16D4`(base32)
`${crc32}` -> `6292fd23`
`${crc64}${unixtime_retrieved}` -> `6292fd23.1JQ16D4` (concat prev two)


In-text reference examples:
---------

As markdown comment immediately following a link: (`${crc64}${unixtime_retrieved}`)
```markdown
* ["title" - "description"](original_link) <!-- refid="6292fd23.1JQ16D4" -->
```


----------
DB file structure examples:

DB file might look like:
```jsonl
## HEADER_COMMENT_LINES
## HEADER_COMMENT_LINES
{SOME_JSON_RECORD}
{SOME_JSON_RECORD}
## SOME COMMENT
{SOME_JSON_RECORD}
{SOME_JSON_RECORD}
```




----------


For saved files, extra metadata to find correct file (using JSON in markdown comment):
* ["TITLE" (pdf)](LINK) <!-- {"filename": "", "size_bytes": 0, "retreival_unixtime": 0, "crc32": "", "md5sum": "", "sha128sum": "", "sha256sum": ""} -->


----------



----------

## Links
* https://en.wikipedia.org/wiki/Base36
* https://en.wikipedia.org/wiki/Binary-to-text_encoding
