# RenPy (Visual Novels)
RenPy is a Python-based game engine most prominently used for Visual Novels.


## Builtin Developer utils
Certain key combos open developer tools if proper config vars are set to the proper values.
- ["Shift+O Console" - "Developer Tools" (RenPy docs)](https://www.renpy.org/doc/html/developer_tools.html#shift-o-console)
- ["Shift+E Editor Support" - "Developer Tools" (RenPy docs)](https://www.renpy.org/doc/html/developer_tools.html#shift-e-editor-support)
- ["Shift+D Developer Menu" - "Developer Tools" (RenPy docs)](https://www.renpy.org/doc/html/developer_tools.html#shift-d-developer-menu)
- ["Shift+R Reloading" - "Developer Tools" (RenPy docs)](https://www.renpy.org/doc/html/developer_tools.html#shift-r-reloading)
- ["Shift+I Style Inspecting" - "Developer Tools" (RenPy docs)](https://www.renpy.org/doc/html/developer_tools.html#shift-i-style-inspecting)
* ["Debug Functions" - "Developer Tools" (RenPy docs)](https://www.renpy.org/doc/html/developer_tools.html#debug-functions)


Value that needs to be set:
```python
define config.developer = True # Developer tools enabled.
```

Get current line: (Open console via `[Shift]+O` )
```python
renpy.get_filename_line()
```

Warp to line: (Open console via `[Shift]+O` )
```python
renpy.warp_to_line("filename:linenumber")
```


### unpra util
Renpy games often come with resources bundled in `.rpa` archive files, `unrpa` is a python library to extract them that comes with a command-line interface.

Installing unrpa: (In Powershell on Windows) CHECKME
```bash
python3 -m pip install "unrpa"
```

Extracting .rpa files all at once: (In bash on Linux) CHECKME
```bash
cd game/
python3 -m unrpa ./**.rpa
```

Installing unrpa: (In Powershell on Windows) CHECKME
```powershell
py -m pip install unrpa
```

Extracting .rpa files all at once: (In Powershell on Windows)
```powershell
py -m unrpa (get-item .\*.rpa)
```


### Enabling rollback in RenPy
* TODO: Figure out method to enable rollback. (TODO: Split topic off into seperate file)
* ["Saving, Loading, and Rollback" (RenPy docs)](https://www.renpy.org/doc/html/save_load_rollback.html)
* ["Rollback" - "Saving, Loading, and Rollback" (RenPy docs)](https://www.renpy.org/doc/html/save_load_rollback.html#rollback)
* ["Blocking Rollback" - "Saving, Loading, and Rollback" (RenPy docs)](https://www.renpy.org/doc/html/save_load_rollback.html#blocking-rollback)
* [Rollback " - "Configuration Variables" (RenPy docs)](https://www.renpy.org/doc/html/config.html#rollback)
* [rollback in renpy source code (github)](https://github.com/renpy/renpy/blob/master/renpy/rollback.py)

Stopping games from stopping rollback gamewide:
`[ctrl]+o` to open console then enter: (UNTESTED)
```python
define config.hard_rollback_limit = 100 # Default.
define config.rollback_length = 128 # Default.
define config.rollback_enabled = True # Default.
```

Stopping games from stopping rollback from a scene:
`[ctrl]+o` to open console then enter: (UNTESTED)
```python
def renpy.fix_rollback(): pass
```


## Files
Relevant files in this repo.
* (nonfree/renpy/)
* (nonfree/renpy/extractrpa.py)
* (nonfree/renpy/enable_rollback.rpy)


## Links
### RenPy docs
* ["Saving, Loading, and Rollback" (RenPy docs)](https://www.renpy.org/doc/html/save_load_rollback.html)
* ["Configuration Variables " (RenPy docs)](https://www.renpy.org/doc/html/config.html#var-config.rollback_enabled)
* ["Developer Tools" (RenPy docs)](https://www.renpy.org/doc/html/developer_tools.html)
* Information on RenPy in web browsers: ["Web / HTML5" (RenPy docs)](https://www.renpy.org/doc/html/web.html)
* Game may dynamically load resources from web: ["Progressive Downloading" - "Web / HTML5" (RenPy docs)](https://www.renpy.org/doc/html/web.html#progressive-downloading)
* Game may be released as multi-stage loader: ["Downloader for Large Games on Mobile" (RenPy docs)](https://www.renpy.org/doc/html/downloader.html)
* ["" (RenPy docs)]()


### RenPy utils - 3rd-party
* ["RPA Extract"](https://iwanplays.itch.io/rpaex)
* https://github.com/Nyarstot/EXTRActor
* ["renpy RPA v3 extractor" "extractrpa.py" (gist.github)](https://gist.github.com/dekarrin/36f1908aa794f92e50b46c58a604dee0) [Included in repo: "extractrpa.py"](./nonfree/renpy/extractrpa.py)
* [unrpyc releases (Github)](https://github.com/CensoredUsername/unrpyc/releases)
* (https://github.com/xaxa9551/De_RenPy)
* ["unrpyc" - "A ren'py script decompiler " (github)](https://github.com/CensoredUsername/unrpyc)
* [](https://github.com/Shizmob/rpatool)
* [](https://github.com/Lattyware/unrpa)
* []()


### RenPy guides
* https://www.reddit.com/r/RenPy/wiki/guides/decompiling


### Enabling rollback in RenPy
* TODO: Figure out method to enable rollback. (TODO: Split topic off into seperate file)
* ["Saving, Loading, and Rollback" (RenPy docs)](https://www.renpy.org/doc/html/save_load_rollback.html)
* ["Rollback" - "Saving, Loading, and Rollback" (RenPy docs)](https://www.renpy.org/doc/html/save_load_rollback.html#rollback)
* ["Blocking Rollback" - "Saving, Loading, and Rollback" (RenPy docs)](https://www.renpy.org/doc/html/save_load_rollback.html#blocking-rollback)
* [Rollback " - "Configuration Variables" (RenPy docs)](https://www.renpy.org/doc/html/config.html#rollback)
* [rollback in renpy source code (github)](https://github.com/renpy/renpy/blob/master/renpy/rollback.py)


### Unsorted links

