# task1 coursework

#! /usr/bin/bash

# Replace 'username with the actual username'
USERS=$(cut -d: -f1 /etc/passwd)

# Initialize total CPU time, total Memory and toal open files
TOTAL_CPU=0
TOTAL_MEM=0
TOTAL_FILES=0

# Header for the report
printf "%-10s %-10s %-10s %-10s\n" "PID" "CPU(s)" "MEM(MB)" "FILES"
for USER in $USERS; do
    # Get the PIDs of all processes belonging to the user
    PIDS=$(pgrep -u $USER)

    # Initialize user CPU time, mem, and open files
    USER_CPU=0
    USER_MEM=0
    USER_FILES=0

    for PID in $PIDS; do
        # Get the CPU time used by the process
        CPU=$(ps -p $PID -o cputime= | awk -F '[:.]' '{ print ($1 * 3600) + ($2 *60) + $3 }')
        USER_CPU=$((USER_CPU + CPU))

        # Get the memory used by the process
        MEM=$(pmap $PID | tail -n 1 | awk '/total/ {print $2}' | sed 's/K//')
        MEM=$(echo "scale=2; $MEM / 1024" | bc)
        USER_MEM=$(echo "$USER_MEM + $MEM" | bc)

        # Get the number of open files by the process
        FILES=$(lsof -p $PID | wc -l)
        USER_FILES=$((USER_FILES + FILES))
    done

    # Print the total info
    printf "%-10s %-10s %-10s %-10s\n" "$USER" "$USER_CPU" "$USER_MEM" "$USER_FILES"

    # Add the user's stats to the total stats
    TOTAL_CPU=$((TOTAL_CPU + USER_CPU))
    TOTAL_MEM=$(echp "$TOTAL_MEM + $USER_MEM" | bc)
    TOTAL_FILES=$((TOTAL_FILES + USER_FILES))
done

printf "%-10s %-10s %-10s %-10s\n" "TOTAL" "$TOTAL_CPU" "$TOTAL_MEM" "$TOTAL_FILES"

sort -k2 -nr