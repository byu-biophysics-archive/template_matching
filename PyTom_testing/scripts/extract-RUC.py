#!/usr/bin/env python3

import re
import argparse

def extract_ruc_value(svg_file):
    """
    Extract the RUC value from an SVG file.

    Args:
        svg_file (str): Path to the SVG file.

    Returns:
        float: The extracted RUC value if found.
        None: If the RUC value is not found.
    """
    pattern = r'<!-- RUC:\s*([\d.]+)\s*-->'
    
    with open(svg_file, 'r') as file:
        content = file.read()
    
    match = re.search(pattern, content)
    
    if match:
        return float(match.group(1))
    else:
        return None

def main():
    """
    Main function to parse command-line arguments and extract the RUC value.
    """
    parser = argparse.ArgumentParser(
        description='Extract RUC value from an SVG file.',
        epilog='Use -h or --help to get this help message.'
    )
    
    parser.add_argument(
        '-p', '--path', 
        required=True, 
        help='Path to the SVG file from which to extract the RUC value.'
    )

    args = parser.parse_args()

    ruc_value = extract_ruc_value(args.path)
    
    if ruc_value is not None:
        print (ruc_value)
    else:
        print("RUC value not found in the SVG file.")

if __name__ == '__main__':
    main()
