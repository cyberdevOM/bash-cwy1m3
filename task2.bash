#! /usr/bin/bash

USERS=$(cut -d: -f1 /etc/passwd)

REPORT=$(mktemp)

printf "%-20s %-10s %-10s %-10s\n" "USER" "SETUID" "SETGID" "WORLD-WRITEABLE" > $REPORT

for USER in $USERS; do
    SETUID_FILES=$(find / -user $USER -perm -4000 -type f 2>/dev/null)
    SETGID_FILES=$(find / -user $USER -perm -2000 -type f 2>/dev/null)
    WORLD_WRITABLE_FILES=$(find / -user $USER -perm -2 ! -type l -type f 2>/dev/null)

    echo "Setuid files:"
    echo "$SETUID_FILES"
    echo "Setgid files:"
    echo "$SETGID_FILES"
    echo "World-writeable files:"
    echo "$WORLD_WRITABLE_FILES"
    echo "---------------------------------------"
done