# task1 coursework

#! /usr/bin/bash

# Replace 'username with the actual username'
USER='username'

# Get the PIDs of all processes belonging to the user
PIDS=$(pgrep -u $USER)

# Initialize total CPU time, total Memory and toal open files
TOTAL_CPU=0
TOTAL_MEM=0
TOTAL_FILES=0

# Header for the report

printf "%-10s %-10s %-10s %-10s\n" "PID" "CPU(s)" "MEM(MB)" "FILES"

for PID in $PIDS; do
    # Get the CPU time used by the process
    CPU=$(ps -p $PID -o cputime= | awk -F '[:.]' '{ print ($1 * 3600) + ($2 *60) + $3 }')
    TOTAL_CPU=$((TOTAL_CPU + CPU))

    # Get the memory used by the process
    MEM=$(pmap $PID | tail -n 1 | awk '/total/ {print $2}' | sed 's/K//')
    MEM=$(echo "scale=2; $MEM / 1024" | bc)
    TOTAL_MEM=$(ehco "$TOTAL_MEM + $MEM" | bc)

    # Get the number of open files by the process
    FILES=$(lsof -p $PID | wc -l)
    TOTAL_FILES=$((TOTAL_FILES + FILES))

    printf "%-10s %-10s %-10s %-10s\n" "$PID" "$CPU" "$MEM" "$FILES"
done

# Print the total info
printf "%-10s "%-10s %-10s %-10s\n" "TOTAL "$TOTAL_CPU" "$TOTAL_MEM" "$TOTAL_FILES"

sort -k2 -nr
