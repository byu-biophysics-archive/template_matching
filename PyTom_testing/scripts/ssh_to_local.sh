#!/bin/bash

# Define variables
LOCAL_USER="jblaser2"                # Local machine username
LOCAL_HOST="Joshs-Air-5.app.byu.edu" # Local machine IP address or hostname
LOCAL_PATH="~/Research/TM/stuff_to_look_at/"  # Path to the destination on the local machine

# Function to display help message
function display_help() {
    echo "Usage: $0 /path/to/remote/file"
    echo
    echo "This script copies a specified file from a remote server to the local machine."
    echo
    echo "Arguments:"
    echo "  /path/to/remote/file   The absolute path to the file on the remote server that you want to copy."
    echo
    echo "Options:"
    echo "  -h, --help             Display this help message."
    exit 0
}

# Check if the help option is called
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    display_help
fi

# Check if the remote file path is provided as an argument
if [ -z "$1" ]; then
    echo "Error: Remote file path is required."
    echo "Use -h or --help for usage information."
    exit 1
fi

REMOTE_FILE="$1"  # Path to the file on the remote server provided as the first argument

# Use scp to copy the file to the local machine from the remote SSH session
scp "$REMOTE_FILE" "${LOCAL_USER}@${LOCAL_HOST}:${LOCAL_PATH}"

# Confirm the file has been copied
echo "File copied to ${LOCAL_PATH}"
