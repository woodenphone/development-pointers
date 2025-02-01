# Running Ansible on Windows via WSL (Windows Subsystem for Linux)

## Index



#### Non-native toolchain setup - Ansible on WSL (Advanced workspace configuration)
* TODO: Considerations when using WSL - paths, etc.
* TODO: Considerations when using WSL - Project in Windows FS or in WSL Linux FS - performance difference.


* TODO: Ansible inventory for these examples.



##### Install ansible on WSL
* TODO: Ansible install on WSL
```bash
apt update && apt upgrade

apt install ansible
```


#### Running a VSCode Workspace in WSL
* TODO: Workspace located in WSL FS

#### Running a VSCode Workspace
* TODO: Workspace located in Windows FS


##### VSCode Language server for Ansible
* TODO: VSCode workspace config - Ansible extention language server?


##### VSCode Run configs for ansible project
* TODO: VSCode workspace config - Ansible run config json(s) (--syntax-check, --check, deploy to test,deploy to prod)
`.vscode\launch.json`

* TODO: Valid launch configuration example. ! WIP !
```json
    "configurations": [
        {
            "name": "Anible Syntax-Check: Current File",
            "type": "debugpy",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        },
```

* See file: `examples\vscode-wsl-ansible\.vscode\launch.json`



## Links

