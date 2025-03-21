# Development pointers - README
(Starting point file)

This is meant to be a startingpoint to both get good enough at subjects and refresh knowledge (ex. after several months or years since doing some task).

This repo is a combination linkdump and collection of scripts, examples, and guides.


## Repo status
This repo is very Work-In-Progress. (Basically Alpha.)

Files may move or be refactored heavily at any time

If you are linking to something in this repo you should use a link referencing the specific git commit to prevent it breaking from updates.

* TODO: Example link to specific line in file for specific commit.

Due to scope creep, distractions, and so on, many files are barely started with significant amounts of research and writing needing to be done to fill them out.
Check the sources and validate things here yourself; things are added in haphazardly and there are likely commands and scripts that are incorrect due to hapahazard development.

Most of what's here should be largely right; a decent starting-point to get your things working.


## How to efficiently use this documentation
* Make use of "Find-in-files" and keywords relating to your topic.
* When reading, skim to get an idea of what's covered where before attempting to read in full depth - This isn't a novel.
* Copy-paste commands and code from here as required to do your task, especially with scripting. 


## Index of dirs
Index of what dirs contain what sort of thing.

`barely-started/` - Documents that are very minimal and need lots of work.
`bin/` - Scripts and similar relating to this repo.
`examples/` - Example scripts, configs, etc.
`guides/` - Contain explainations and examples, not just links.
`nonfree/` - Anything here is by someone unrelated to this repo; I just add infoheaders and such to these. (The parts of these I did not write are excluded from the license)
`img/` - Pictures to illustrate things better.
`meta/` - Documents, etc. relating to working on this repo.
`powershell/` Powershell related documents.
`windows/` - Documents related to various Windows topics.



## Advice
Advice for efficiency and practicality in development etc.
* Document things you do with a level of detail enough for the assumption that you will need to come back and re-do or update whatever you did six months later after you've forgotten most of what you did.
* Markdown (`foo.md`) is generally better for notes than plain text (`bar.txt`) because syntax highlighting and ease of conversion and publishing.
* Make your own git repo of semi-organized notes and scripts as you write your stuff. e.g. `my-notes/bash/test-new-hdd.sh` `my-notes/mysql/mysql-notes.md` `my-notes/topic/subtopic/document.md`
* If you go to the effort of learning something, take notes in a file.
* Record where you found information so you can go back and check the source again later. (This is perhaps the single biggest justification for writing citations and bibliographies.)
* Save copies of anything you find useful just in case the original source dissapears (web pages, scripts, PDF files, other documentation, even git repos potentially).

Example:
```markdown
* [Link text](http://example.com/some-page.htm)
So to do  [example thing](http://example.com/some-page.htm) we run the commands:
```

* Figure out your commands in a text editor and copy-paste to/from the CLI to execute them.

* Put tasks you run repeatedly in its own alias or script file so you have it documented.

Easy lazy way to throw things you keep doing into a script:
```bash
echo " some-command param1 param2 param3; other-command; " > somename.sh
```

* Enable command history for your shell, prefereably with date+time-stamping of history entries.

* Use descripting variable names.
* Comment your code.
* Use a header comment to remember who wrote what and when.


I try to write documentation readable by a novice - if the kid down the street or adult not specialized in the subject can't get things working to a basic level using the documentation, the documentation isn't good enough.
(Obviously giving them an open terminal, graphical file operations client and text editor.)

Lots of copypasta examples for how to do the task.

Simple and logical layout, with tasks ordered in the documentation as you would normally do them.


## Other repos by me
* Ansible project to setup a Windows laptop: https://gitgud.io/Ctrl-S/thinkpad-ansible.public
* Pertinent and most developed section of repo: https://gitgud.io/Ctrl-S/thinkpad-ansible.public/-/tree/master/windows11
* https://gitgud.io/Ctrl-S/thinkpad-ansible.public/-/tree/master/windows11/notes
