#!/bin/bash

# Directory where the output will be saved
output_dir="/home/library/Linux/Monitoring/scripts/Outputs"

# File to store the output
output_file="$output_dir/top_mem_output.txt"

# Run top command with sorting by memory usage and display only top 10 processes
top -b -n 1 -o %MEM | head -n 17 > "$output_file"

# Print a message indicating where the output is saved
echo "Top 10 memory-consuming processes saved to $output_file"
