#!/bin/bash

# Directory in which the output will be saved
output_dir="/home/library/Linux/Monitoring/scripts/Outputs"

# File to store the output
output_file="$output_dir/memory_usage_output.txt"

# Trigger mpstat -P ALL command and redirect output to file
mpstat -P ALL > "$output_file"

# Print a message indicating where the output is saved
echo "mpstat output saved to $output_file"
