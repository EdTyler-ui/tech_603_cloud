# file permissions

## managing file permission:

### Do owners of files have full permissions?
- no
  - depends on what the user permission bits are set to
  - if on read only, even the owner can only read the file
  - can even lock yourself out of a file

### what does give permissions to the user entity mean?
- Refers to owner of the file

### giving permissions to group entity
- refers to the owning group, permissions granted to the group associated with the file
- not refer to the user entity

### giving permissions to others
- the other entity refers to everyone else

### example:
-rwxr-xr-- 1 tcboony staff  123 Nov 25 18:36 keeprunning.sh
- user is read, write and execute
- group is read and execute
- other is read only

## file permissions using numeric values

### for each permission:
- read = 4
- write = 2
- execute = 1
- no permission = 0

### example: read + write
- 4 + 2 = 6

### what would 644 mean?
- each of the 3 digits maps to one entity
  - user, group and other = 6, 4, 4

## commands that change file permissions

### commands that changes file permissions
- chmod

### what must the end user be to change permissions
- owner of the file or root superuser

### setting permissions on files:
- set user to read, group to rwx and other to rw
  - chmod u=r, g=rwx, o=rw testfile.txt
  - number: chmod 476 testfile.txt
- add execute permission to all entities
  - chmod a+x testfile.txt
- take write permissions away from group
  - chmod g-w testfile.txt
- user:rw, group:r, other:none
  - chmod 640 testfile.txt

## managing file ownership

### why is it important
- crucial for linux security
- prevents unauthorised access from unwanted people
- prevents malicious changes to files

### command to see file ownership
- ls -l

### what permissions are set when users create a file or directory
- it belongs to that user who creates it and the primary group

### why do owners not recieve x by default?
- most files are txt that dont need to be run
- might accidentally execute a file that contains malicious code

### how to change ownership of file/ directory
- chown new_owner filename
