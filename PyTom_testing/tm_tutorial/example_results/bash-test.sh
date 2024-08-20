#!/bin/bash

# Define the path to the SVG file
svg_file_path="./tomo200528_100_roc.svg"

# Call the Python script and capture the output
ruc_value=$(python extract-RUC.py -p "$svg_file_path")

# Check if the output contains "RUC value not found" message
if [[ "$ruc_value" == "RUC value not found" ]]; then
    echo "RUC value not found in the SVG file."
else
    # Print the RUC value
    echo $ruc_value
fi
