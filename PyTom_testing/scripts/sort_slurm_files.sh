#!/bin/bash

# Define destination directory
DEST_DIR="$HOME/TM/outputs"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Find the highest number in the existing files in the destination directory
# If no files are found, set the counter to 1
counter=$(find "$DEST_DIR" -name 'slurm-*.out' | awk -F'[-.]' '{print $2}' | sort -n | tail -1)
counter=$((counter + 1))

# Loop through all files matching the pattern 'slurm-*.out' in the current directory
for file in slurm-*.out; do
    # Check if the file exists (in case there are no matching files)
    if [ -e "$file" ]; then
        # Construct the new filename
        new_filename="slurm-${counter}.out"

        # Move and rename the file
        mv "$file" "$DEST_DIR/$new_filename"

        echo "Moved $file to $DEST_DIR/$new_filename"

        # Increment the counter
        ((counter++))
    fi
done

# Inform the user if no files were found
if [ $counter -eq 1 ]; then
    echo "No slurm-*.out files found in the current directory."
else
    echo "All matching files have been moved and renamed."
fi

