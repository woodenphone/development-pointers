ansible.practical-example.init-from-repo.md
# Example of using ansible
Example: Running playbook from your git repo on the target.

Scenario: You are Mr. J.C. Denton working to set up a fallback communications server in case your organization's main systems fail. 
This will give you and your coleagues IRC, FTP, SMB, and other vital tools independantly of the rest of your org's infrastructure.

(In this scenario the target machine will be acting as both asnible-controller and ansible-target.)


Connecting to the target (commands ran on workstation):
```bash
dentonj@virtudeck-xp:~$
## Connect to the target machine from your workstation:
ssh "ssh://dentonj@recovery-alfa.ny.us.unatco.org"
```


On the target machine:(Commands ran on target)
```bash
dentonj@recovery-alfa:~$

## Installing basic packages for administrative convenience:
sudo dnf install nano vim byobu tmux screen curl wget rsync ssh gnupg tree bash fdisk parted smartmonutils git python python-pip ansible perl

## Enter buoybu-tmux terminal multiplexer for convenience and session stability.
byobu 

## Install ansible:
sudo dnf install -y ansible

## Go to homedir of user who runs playbook
cd ~

## git clone a copy of the playbook repo (optionally specifying destination dir)
git clone "git://git@github.com/UNATCO/playbook-fallback-coordination-server.git" ~/playbook-fallback-coordination-server

cd ~/playbook-fallback-coordination-server

## Bring local up to match HEAD (If we ran 'git clone' a while ago and repo has changed since then.)
git pull 

## Install latest versions of dependancies via ansible-galaxy:
ansible-galaxy collection install --requirements-file=requirements.yml

## Testrun playbook to verify sequence of actions matches expectations:
ansible-playbook -vv --check playbook.yml

## Run playbook for real:
ansible-playbook -vv --check playbook.yml
```


Upgrading the target machine several months later:
```bash
dentonj@recovery-alfa:~$

## Enter buoybu-tmux terminal multiplexer for convenience and session stability.
byobu 

## Install ansible:
sudo dnf update -y

## Go to homedir of user who runs playbook
cd ~

## Enter repo dir for playbook:
cd ~/playbook-fallback-coordination-server

## Bring local up to match HEAD (If we ran 'git clone' a while ago and repo has changed since then.)
git pull 

## Check config vars (optional and highly dependant on your playbook):
nano host_vars/recovery-alfa.yml

## Install latest versions of dependancies via ansible-galaxy:
ansible-galaxy collection install --requirements-file=requirements.yml

## Testrun playbook to verify sequence of actions matches expectations:
ansible-playbook -vv --check playbook.yml

## Run playbook for real:
ansible-playbook -vv --check playbook.yml
```



