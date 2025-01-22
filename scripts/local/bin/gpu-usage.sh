#!/bin/bash

# Get GPU usage using nvidia-smi
get_gpu_usage() {
    # Get GPU utilization percentage
    usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    
    # Get GPU memory usage
    mem_usage=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
    mem_total=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
    
    # Calculate memory percentage
    mem_percent=$(awk "BEGIN {print int(($mem_usage/$mem_total)*100)}")
    
    # Output both GPU usage and memory usage
    echo "$usage% VRAM($mem_percent%)"
}

# If no argument is provided, show usage
if [ "$1" = "" ]; then
    get_gpu_usage
fi
