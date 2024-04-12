#!/bin/bash

# Directory where the output will be saved
output_dir="/home/library/Linux/Monitoring/scripts/Outputs"

# File to store the output
output_file="$output_dir/power_consumption_output.txt"

# Run powerstat command and redirect output to file
# -d option for having a 1 second delay before running the command
# the second number 1 is for ensuring we get a power calculation every second
# -z option is for forcing the readings on a non-discharing device
sudo powerstat -d 1 1 -z > "$output_file" &

# Get the PID of the powerstat process
powerstat_pid=$!

# Wait for 10 seconds because otherwise the output is too big
sleep 10

# Kill the powerstat process
sudo kill $powerstat_pid

# Print a message indicating where the output is saved
echo "Power consumption results saved to $output_file"
