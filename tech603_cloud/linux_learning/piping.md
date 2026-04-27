# piping

## what is piping
- taking the output of one command and using it as an input of another command
- without writing to an intermediate file

## piping commands
- '|' is used to add on a command
- '>' is used to write output to a file
- '>>' append outout to file

## example of using piping once
- ls -l | grep ".txt"
- first command is to open all files 
- second command is to only open files with .txt at the end

## using piping twice
- cat file.txt | sort | uniq
- first command is cat reads file
- second command is file is sorted alphabetically
- last command is all duplicates are removed

## using piping and sending output to file
- cat file.txt | sort | uniq > output.txt
- first command is cat to read file
- second command is to sort alphabetically
- last command removes duplicates 
- ends by creating output file
