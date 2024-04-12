#!/bin/bash

# Directory where the output will be saved
output_dir="/home/library/Linux/Monitoring/scripts/Outputs"

# File to store the output
output_file="$output_dir/hdd_io_output.txt"

# Trigger iostat -h command and redirect output to file
iostat -h > "$output_file"

# Print a message indicating where the output is saved
echo "HDD I/O output saved to $output_file"
