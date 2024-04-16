# Course Work CSEC1002
**linux shell scripting**

## description
These two tasks are coursework designed for my degree, cyber security, as part of my third module Endpoint security.

* Task one is a script that prints a report of the user data for each user as well as the files open by all its processess.

* Task two is a script that prints report of the number of SUID GUID and world writable files for each user.

## Task 1

The requirements for task 1 read as follows

write a shell script that generates a report showing resource utilisation for all system users, Resources are:
    
* Total CPU utilisation, in time units, e.g. seconds, for all processes belonging to the user    
* Total actual physical memory currently used by all proceesses belonging to the user (in MB).
* Total number of files open by all processes belonging to the user.

Your output report should look like the following, where users are sorted in a decending order according to CPU utilisation.

    |------------------------------------------------------------|
    |USER | CPU Utilisation (sec) | Memory (MB) | Number of files|
    |-----|-----------------------|-------------|----------------|
    |user1|                       |             |                |
    |user2|                       |             |                |


## Task 2

The requirements for task 1 read as folows

List the files with the following permissions for every user:

* SetUID & SetGID
* World-writable files and directories
* Unowned files

write a shell script that generates a report showing the total number of files for each category for each user,
Your ouput report should look like the following, where users are sorted in a decending order according to SETuid, Setgid and world writeable files.


    |----------------------------------------------------------------------|------------------|
    |USER | Num Setuid Files | Num Setgid Files | Num World-writable Files | Num Unowned Files|
    |-----|------------------|------------------|--------------------------|------------------|
    |user1|                  |                  |                          |                  |
    |user2|                  |                  |                          |                  |
