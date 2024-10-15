#!/bin/bash

# Function to display usage/help message
show_help() {
    echo "Usage: apache_log_analyzer.sh [OPTIONS] [LOG_FILE]"
    echo ""
    echo "Options:"
    echo "  -h            Display this help message."
    echo "  -e            Display only errors (HTTP status codes 4xx and 5xx)."
    echo "  -i            List unique IP addresses."
    echo "  -d DATE       Filter log by a specific date (format: YYYY-MM-DD)."
    echo ""
    echo "Example:"
    echo "./apache_log_analyzer.sh -e -d 2024-10-11 /var/log/apache2/access.log"
}

# Function to handle invalid arguments
invalid_argument() {
    echo "Error: Invalid argument."
    show_help
    exit 1
}

# Check if no arguments are passed
if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

# Variables
error_only=false
list_ips=false
filter_date=""

# Process options
while getopts "heid:" opt; do
    case ${opt} in
        h)
            show_help
            exit 0
            ;;
        e)
            error_only=true
            ;;
        i)
            list_ips=true
            ;;
        d)
            filter_date=$OPTARG
            ;;
        *)
            invalid_argument
            ;;
    esac
done

# Shift arguments to leave the log file path as the last argument
shift $((OPTIND -1))

# Check if the log file is provided
if [ -z "$1" ]; then
    echo "Error: Log file is required."
    show_help
    exit 1
fi

log_file=$1

# Check if the log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: Log file '$log_file' not found."
    exit 1
fi

# Start analyzing the log file
if [ "$list_ips" = true ]; then
    echo "Unique IP addresses in the log file:"
    grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$log_file" | sort | uniq
    exit 0
fi

if [ "$error_only" = true ]; then
    echo "Showing only errors (HTTP 4xx and 5xx status codes):"
    grep -E "HTTP/[0-9\.]+\" [45][0-9]{2}" "$log_file"
else
    echo "General log analysis:"
    grep -E ".*" "$log_file"
fi

if [ -n "$filter_date" ]; then
    echo "Filtering log by date: $filter_date"
    grep "$filter_date" "$log_file"
fi
