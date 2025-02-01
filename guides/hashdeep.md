# Hashdeep / md5deep
Parralelized bulk file hashing utility.

* Rationale: We may want to do comparisons to hashes of files from other sources which we cannot predict the algos for, so just generate them all.
* Rationale: Much harder to manufacture a hash colision when multiple algos are in use.

* TODO: Copy in utility scripts I wrote relating to hashdeep - i.e. hashlist to SQL python script.


## Installation
dnf
```bash
sudo dnf install md5deep
```

apt
```bash
sudo apt update && sudo apt upgrade
sudo apt install md5deep
```


## Usage
There are two main modes: one creates a hashlist file, the other compares against a hashlist file.

```bash
hashdeep -c ALGOS -r SCAN_PATH > OUTFILE
```
Minimal example of generating hashlist:
```bash
## hashdeep -c ALGOS -r SCAN_PATH > OUTFILE
hashdeep -c 'sha1' -r ~/ > ~/hashlist
```


### Hashlist creation copypasta
Examples for easy low-effort reuse.

More practical copypasta example of generating hashlist:
```bash
## hashdeep -c ALGOS -r SCAN_PATH > OUTFILE
hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "/media/myhdd/dir-to-hash/" > "my-thing-name.$(date +%Y-%m-%d).hashlist"
```

Example with more verbose timestamp:
```bash
## hashdeep -c ALGOS -r SCAN_PATH > OUTFILE
hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "/media/myhdd/dir-to-hash/" > "my-thing-name.$(date +%Y-%m-%dT%H%M%S%z=@%s).hashlist"
```

Gzipping hashlist as it's created:
```bash
## hashdeep -c ALGOS -r SCAN_PATH > OUTFILE
hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "/media/myhdd/dir-to-hash/" | gzip > "my-thing-name.$(date +%Y-%m-%dT%H%M%S%z=@%s).hashlist.gz"
```


Simple use in script:
```bash
#!/usr/bin/env bash
## * * * Your code before hashing * * *
## You'd normally assign these with your own code, but this is an example.
dirpath_to_hash="/media/myhdd/my-wedding-photos/"
hashlist_filepath="$HOME/my-wedding-photos.hashlist"
## Produce hashlist of dir contents:
hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "${dir_to_hash?}" | tee >(md5sum > "${hashlist_filepath?}.md5") > "${hashlist_filepath?}"
## * * * Your code after hashing * * *
exit
```


More complex example of use in script, checking return code and creating md5sum of the hashlist itself:
```bash
#!/usr/bin/env bash
## * * * Your code before hashing * * *
## You'd normally assign these with your own code, but this is an example.
dirpath_to_hash="/media/myhdd/my-wedding-photos"
hashlist_filepath="$HOME/my-wedding-photos.$(date +%Y-%m-%d).hashlist" ## Timestamp in filename so down the line you'll be able to tell when the hashlist was made.
echo "#[${0##*/}] Hashing dirpath_to_hash=${dirpath_to_hash@Q} to hashlist_filepath=${@Q} (at $(date -Is))" >&2
## Stream redirection via 'tee' and >() subshell with file descriptor-pointed at its-stdin are being used to make a md5 checksum of the hashlist itself, as a way to detect if the hashlist itself is corrupt. 
time hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "${dir_to_hash?}" | tee >(md5sum > "${hashlist_filepath?}.md5") > "${hashlist_filepath?}"
hashdeep_retcode="$?" ## 'time' passes on exit code from the timed subprocess.
echo "#[${0##*/}] hashdeep returned with code ${hashdeep_retcode@Q} (at $(date -Is))" >&2
if [[ ${hashdeep_retcode} -ne 0 ]]; then ## Handle posible failure.
    echo "#[${0##*/}] Fatal error: hashdeep gave unexpected nonzero return code, exiting. hashdeep_retcode=${hashdeep_retcode@q} (at $(date -Is))" >&2
    exit 1 ## Nonzero signifies an error occured.
fi ## At this point we are moderately confident we've got our hashlist.
## * * * Your code after hashing * * *
exit
```


### Validating files match hashlist
* TODO


### Example shell scripts
* TODO: local file link(s) to copy of shell script(s) utilizing hashdeep.


### Helper scripts
* TODO: local file link to copy of my python hashdeep to sqlite script.
* TODO: local file link to copy of my python hashdeep to mysql script.


## Performance (theoretical)
* TODO: Review source code to determine if all algos get run alongside with single file read pass (i.e. no added open/close/read/stat bottleneck when multiple hash algos in use).
Hashing is performed in ["hash.cpp"](https://github.com/jessek/hashdeep/blob/master/src/hash.cpp)


## Alternatives
- Shell script that recursively traverses dirs and runs md5sum.
- `shafs` (Util that recursively hashes files to a sqlite DB; single-threaded.)


## Links
* Github repo for hashdeep: https://github.com/jessek/hashdeep
* Code that actually performs hashing operations ("hash.cpp"): https://github.com/jessek/hashdeep/blob/master/src/hash.cpp
