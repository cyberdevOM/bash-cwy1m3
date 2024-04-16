#! /usr/bin/bash

USERS=$(cut -d: -f1 /etc/passwd)

REPORT=$(mktemp)
HEADER=$(mktemp)

printf "%-20s %-10s %-10s %-10s %-10s\n" "USER" "SETUID" "SETGID" "WORLD-WRITEABLE" "OTHER" > $HEADER

echo "generating report...."

for USER in $USERS; do
    echo "Processing user: $USER"

    SETUID_FILES=$(find / -user $USER -perm -4000 -type f 2>/dev/null)
    SETGID_FILES=$(find / -user $USER -perm -g+s -type f 2>/dev/null)
    WORLD_WRITABLE_FILES=$(find / -user $USER -perm -2 ! -type l -type f 2>/dev/null)
    UNOWNED_FILES=$(find / -type f ! -user $USER 2>/dev/null)
    #ALL_FILEs=$(find / -user $USER -type f 2>/dev/null | sort | uniq)

    SETUID_COUNT=$(echo "$SETUID_FILES" | wc -l)
    SETGID_COUNT=$(echo "$SETGID_FILES" | wc -l)
    WORLD_WRITABLE_COUNT=$(echo "$WORLD_WRITABLE_FILES" | wc -l)
    UNOWNED_COUNT=$(echo "$UNOWNED_FILES" | wc -l)
    #ALL_COUNT=$(echo "$ALL_FILES" | wc -l)

    #OTHER_COUNT=$((SPECIAL_COUNT - ALL_COUNT))

    printf "%-20s %-10s %-10s %-15s %-10s\n" "$USER" "$SETUID_COUNT" "$SETGID_COUNT" "$WORLD_WRITABLE_COUNT" "$UNOWNED_COUNT" >> $REPORT
done

sort -k2,2nr -k3,3nr -k4,4nr $REPORT -o $REPORT

cat $HEADER
cat $REPORT
 
rm $REPORT
rm $HEADER