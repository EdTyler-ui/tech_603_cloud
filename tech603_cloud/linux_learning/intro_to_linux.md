# Linux learning

- [Linux learning](#linux-learning)
  - [why learn linux](#why-learn-linux)
  - [What is linux?](#what-is-linux)
  - [what is bash?](#what-is-bash)
  - [what is a shell?](#what-is-a-shell)
  - [What is a process](#what-is-a-process)
  - [linux commands](#linux-commands)
    - [information about current session](#information-about-current-session)
    - [moving around folders](#moving-around-folders)
    - [downloading files](#downloading-files)
    - [editing, moving and removing files/directories](#editing-moving-and-removing-filesdirectories)
    - [creating and viewing files](#creating-and-viewing-files)
    - [viewing parts of a file](#viewing-parts-of-a-file)
    - [installing tree](#installing-tree)
    - [accessing folders in root](#accessing-folders-in-root)
    - [observe environment and edit](#observe-environment-and-edit)
    - [how to add env persistently](#how-to-add-env-persistently)
    - [Process command](#process-command)
    - [real- time system monitor](#real--time-system-monitor)
    - [Managing system processes](#managing-system-processes)
    - [killing a process](#killing-a-process)

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

## What is a process
- A program that is loaded into RAM and could be using CPU 
- a single cpu runs one process at a time
- can run multiple CPU for multiple processes
- Two types of processes
  - User processes
    - usually run by a user and linked to the shell session in which they were run
  - system processes
    - most of them running
    - dont usually provide an application or interface for the end user
    - they provide services like:
      - a web server
      - ftp server
      - a file service
      - a print service
      - a logging service


## linux commands

### information about current session
- 'uname -a' : display info of current OS
- 'whoami' : what is running
- 'ps -p $$' : shows if youre running on bash
- 'histroy' : shows commands ran ('-c' to clear)

### moving around folders
- 'ls': shows files/ folders
  - 'ls -a': shows hidden files/folders
  - 'ls -la' : shows hidden files/folders and permissions
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
- rm -r directory: delete a directory containing files
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
- sudo apt update: just checks what packages need updating 
- sudo apt install tree: 
- tree: shows folder organisation 
- sudo apt upgrade: would not run on an untested environment DANGEROUS CODE. changing version to latest package not compatible with older stuff
  - sudo apt upgrade -y: if theres a message it just runs yes

### accessing folders in root
- cd .. to /: / is the root directory
- sudo su: login as the root, can now look in folders in root directory
- exit to return to ubuntu login

### observe environment and edit
- printenv: shows infomation about your environment
- it is case sensitive
- printenv MYNAME: makes variable called myname
- echo hello: like pythons print()
- echo $MYNAME: print variable, $ so it prints whats in variable not just the word 'variable'
- export MYNAME=edward: creates a env variable
- setting environment variable does not persist, when logging out and in, you will have to set new env variable

### how to add env persistently
- Needed if youre doing repetitive tasks usign same variables
- Enter .bashrc script in hidden folders in home folder using nano
- export VARIABLE=name_is_persistent
- source .bashrc: reload certain configuration files
- printenv variable should now present the new environment

### Process command
- ps: shows prcoesses running in current terminal, static snapshot
- format = process ID, terminal, CPU time used, command
- ps -A: shows all processes in a system, background and other users ps
- ps -E: shows processes with their environment variables
- ps aux: processes for all users, user-oriented format and includes processes without a terminal
    - Tells you CPU usage, memory and virtual, process state, start time and CPU time

### real- time system monitor

- shows the continuous update of info on running process
- top: showsl ive dashboard of cpu usage, memory, number of processes, system uptime
  - inside top
    - shift + p: shows cpu- heavy processes at top
    - shift + m: shows processes using the most RAM
    - shift + n: sort by newest processes
- htop: better visualisation version of top, shows colour coded bars for CPU, RAM. Easy process management and kill certain processes

### Managing system processes
- sleep 3: put delay between each command for 3 seconds
- sleep 5000 &: runs process in background, gives process id as output
- jobs: see processes running in background
  - jobs -l: shows process ID
- control c to break out of processes engaged in terminal

### killing a process
- kill -1 processid: gentle way to remove process
  - shuts down child process first before parent process
- kill -15 processid: standard level of kill (uses when u dont specifty a number)
  - shut down child process first
- kill -9 processid: brute force kill DANGEROUS CODE
  - shuts down parent process so child processes continue running (zombie processes)
- PM2 used to recreate a new process after killing it, provides contiuous back up so app crashing does not cause a hault 