#!/bin/bash

# Directory where the output will be saved
output_dir="/home/library/Linux/Monitoring/scripts/Outputs"

# File to store the output
output_file="$output_dir/network_load_output.txt"

# Trigger iftop -h command and redirect output to file
sudo iftop -t -s 10 > "$output_file"

# Print a message indicating where the output is saved
echo "Network current load saved to $output_file"
