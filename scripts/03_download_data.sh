#!/bin/bash
# Script 3: Download GWAS summary statistics from EBI GWAS Catalog
# CAD data: GCST90132314 (Aragam et al. 2022, Nature Genetics)
# RA data: GCST90132223 (Ishigaki et al. 2022, Nature Genetics)
# Author: Gautami Deshpande
# Date: April 2026

cd ~/GWAS_project/data

# Download CAD data
echo "Downloading CAD data..."
wget https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90132001-GCST90133000/GCST90132314/GCST90132314_buildGRCh37.tsv
wget https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90132001-GCST90133000/GCST90132314/README.txt

# Download RA data
echo "Downloading RA data..."
wget https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90132001-GCST90133000/GCST90132223/GCST90132223_buildGRCh37.tsv.gz
wget https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90132001-GCST90133000/GCST90132223/README.txt

# Check headers
echo "Checking CAD file header..."
head -n 3 GCST90132314_buildGRCh37.tsv

echo "Checking RA file header..."
zcat GCST90132223_buildGRCh37.tsv.gz | head -n 3

echo "Download complete"
