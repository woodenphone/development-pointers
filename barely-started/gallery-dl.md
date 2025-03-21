# gallery-dl 
* https://github.com/mikf/gallery-dl

## Install
* Read actual official docs: [Installation guide on github readme.md](https://github.com/mikf/gallery-dl#installation)

Or just use Pip:
```bash
python3 -m pip install -U gallery-dl
```


## Quickref command copypasta
```bash


```



## Config file
* https://gdl-org.github.io/docs/configuration.html

* default values [gallery-dl.conf](https://gdl-org.github.io/docs/gallery-dl.conf)

```bash
wget https://gdl-org.github.io/docs/gallery-dl.conf
```

Comments are supported in config JSON by using `"#"` as the key:
```json
{
"#": "## ==========< Shared between sites >========== ##",
    "extractor":
    {
        "#": "write tags for several *booru sites",
        "postprocessors": [
            {
                "name": "metadata",
                "mode": "tags",
                "whitelist": ["danbooru", "moebooru", "sankaku"]
            }
        ],
"#": "## ==========< /Shared between sites >========== ##",

"#": "## ==========< Sites >========== ##",
	}
}
```



## Tools to manipulate config files easier
* https://ilya-sher.org/2018/04/10/list-of-json-tools-for-command-line/

* https://jqlang.org/

Add entry for some site
```bash
jq 

```





## Links
* https://github.com/mikf/gallery-dl
* https://gdl-org.github.io/docs/configuration.html
* https://gdl-org.github.io/docs/formatting.html



