# Linux learning

- [Linux learning](#linux-learning)
  - [why learn linux](#why-learn-linux)
  - [What is linux?](#what-is-linux)
  - [what is bash?](#what-is-bash)
  - [what is a shell?](#what-is-a-shell)
  - [linux commands](#linux-commands)
    - [information about current session](#information-about-current-session)
    - [moving around folders](#moving-around-folders)
    - [downloading files](#downloading-files)
    - [editing, moving and removing files/directories](#editing-moving-and-removing-filesdirectories)
    - [creating and viewing files](#creating-and-viewing-files)
    - [viewing parts of a file](#viewing-parts-of-a-file)
    - [installing tree](#installing-tree)
    - [accessing folders in root](#accessing-folders-in-root)
    - [](#)

<br>


## why learn linux

- fast- growing
- inexpensive (some do require liscence)
- flexible, scales well
- often used in DevOps
- stable
- more deployable

## What is linux?

- A spinoff of Unix OS
- Unix used to be used on large mainframes
- Linux can be run on small or large computers now
- made up of kernal (core OS), plus libraries/ utilities that rely on the kernal
- many different distributions

## what is bash?

- stands for bourne again shell
- most common shell used in linux

## what is a shell?

- runs the commands behind the terminal
- command line intepreter
- range of shells but bash most common


## linux commands

### information about current session
- uname -a: display info of current OS
- whoami: what is running
- ps -p $$: shows if youre running on bash
- histroy: shows commands ran ('-c' to clear)

### moving around folders
- ls: shows files/ folders
  - ls -a: shows hidden files/folders
  - ls -la: shows hidden files/folders and permissions
- cd: change directory ('cd .' is current directory and 'cd ..' is home directory)
- pwd: where you are in folders

### downloading files
- curl url --output name.jpg: download from website and creates file to output the url (complex)
- wget url --output name.jpg: same as curl (simple)
- 
### editing, moving and removing files/directories
- mv filename1 filename2: renames file 1 to file 2
- cp filename1 filenam2: make copy of filename 1 with filename 2 as name
- rm filename: delete the file DANGEROUS CODE
- rm -r filename: delete a directory containing files
- mkdir: makes a new folder
- rm -d directory: removes empty directory

### creating and viewing files
- touch filename: used to make file
- nano filename: edit the file
- cat filename: print file to screen
- less filename: view file in nano screen/ no editing

### viewing parts of a file
- head -2 filename: shows first 2 lines
- tail -2 filename: shows bottom 2 lines
- nl filename: shows number of each line
- cat filename | grep word/phrase: finds a word or phrase in a file

### installing tree
- sudp apt update: just checks what packages need updating 
- sudo apt install tree: 
- tree: shows folder organisation 
- sudo apt upgrade: would not run on an untested environment DANGEROUS CODE. changing version to latest package not compatible with older stuff
  - sudo apt upgrade -y: if theres a message it just runs yes

### accessing folders in root
- cd .. to /: / is the root directory
- sudo su: login as the root, can now look in folders in root directory
- exit to return to ubuntu login

### 