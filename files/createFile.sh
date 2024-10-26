#!/bin/bash

# Script to create a dummy PDF file with user-specified size

# Prompt user for file size in MB
read -p "Enter the desired file size in MB: " fileSize

# Check if the input is a valid number
if ! [[ "$fileSize" =~ ^[0-9]+$ ]]; then
  echo "Error: Please enter a valid number."
  exit 1
fi

fileName="example.pdf"
# Create a random binary file of the specified size
dd if=/dev/urandom bs=1M count=$fileSize of=dummy.bin

# Create a valid PDF header and save to a new PDF file
echo "%PDF-1.4\n1 0 obj\n<<>>\nendobj\nxref\n0 1\n0000000000 65535 f \ntrailer\n<<>>\nstartxref\n9\n%%EOF" > $fileName

# Append the random binary data to the PDF file
cat dummy.bin >> $fileName

# Remove the temporary binary file
rm dummy.bin

echo "$fileSize MB dummy PDF created: $fileName"
