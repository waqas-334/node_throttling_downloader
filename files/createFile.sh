#!/bin/bash

# Script to create a 500MB dummy PDF file
fileName="example.pdf"
# Create a 500MB random binary file
dd if=/dev/urandom bs=1M count=500 of=dummy.bin

# Create a valid PDF header and save to a new PDF file
echo "%PDF-1.4\n1 0 obj\n<<>>\nendobj\nxref\n0 1\n0000000000 65535 f \ntrailer\n<<>>\nstartxref\n9\n%%EOF" > $fileName

# Append the random binary data to the PDF file
cat dummy.bin >> $fileName

# Remove the temporary binary file
rm dummy.bin

echo "500MB dummy PDF created: dummy.pdf"
