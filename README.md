# Apache Log Analyzer

## Description

`apache_log_analyzer.sh` is a bash script designed to analyze Apache log files and extract useful information such as:
- Error reports (HTTP status codes 4xx and 5xx)
- Unique IP addresses making requests to the server
- Filtering log entries by date

This script is useful for system administrators who need to quickly diagnose issues in their Apache server logs, view general trends, or isolate errors based on certain time periods.

## Features

- **Filter by Error Status Codes**: The `-e` option allows you to filter log entries with HTTP 4xx and 5xx errors.
- **List Unique IPs**: Use the `-i` option to list all unique IP addresses found in the logs.
- **Filter by Date**: You can filter log entries by a specific date using the `-d` option (format: YYYY-MM-DD).
- **Help Option**: The `-h` option displays usage information.

## Usage

```bash
./apache_log_analyzer.sh [OPTIONS] [LOG_FILE]
