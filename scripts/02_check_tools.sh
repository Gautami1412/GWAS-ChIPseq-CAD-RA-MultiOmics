#!/bin/bash
# Script 2: Verify all required tools are available
# Author: Gautami Deshpande
# Date: April 2026

echo "Checking required tools..."

which bedtools
bedtools --version

which awk
which grep
which sort
which uniq
which wget
which python3
python3 --version

echo "Tool check complete"
