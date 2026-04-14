#!/bin/bash
# Script 8: eQTL validation using eQTLGen Phase 1
# Queries 15 shared regulatory SNPs against eQTLGen whole blood data
# n = 31,684 samples across 37 cohorts
# Author: Gautami Deshpande
# Date: April 2026

cd ~/GWAS_project/data

# Download eQTLGen cis-eQTL data
echo "Downloading eQTLGen Phase 1 cis-eQTL data..."
wget https://download.gcc.rug.nl/downloads/eqtlgen/cis-eqtl/2019-12-11-cis-eQTLsFDR0.05-ProbeLevel-CohortInfoRemoved-BonferroniAdded.txt.gz

# Check file header
echo "Checking file header..."
zcat 2019-12-11-cis-eQTLsFDR0.05-ProbeLevel-CohortInfoRemoved-BonferroniAdded.txt.gz | head -n 2

# Create list of 15 shared regulatory SNPs
echo "Creating SNP list..."
cat > my_snps.txt << 'EOF'
rs1071742
rs1071743
rs12721717
rs3173419
rs17878838
rs9264671
rs2308466
rs2523600
rs697742
rs9266144
rs1131223
rs1071817
rs2596492
rs41563412
rs9266196
EOF

# Filter eQTLGen file for our SNPs
echo "Filtering eQTLGen data for 15 shared regulatory SNPs..."
zcat 2019-12-11-cis-eQTLsFDR0.05-ProbeLevel-CohortInfoRemoved-BonferroniAdded.txt.gz | \
    grep -wFf my_snps.txt > eqtlgen_my_snps.txt

echo "eQTL hits found: $(wc -l < eqtlgen_my_snps.txt)"
head -5 eqtlgen_my_snps.txt

# Add header to final results file
echo "Creating final results file with header..."
zcat 2019-12-11-cis-eQTLsFDR0.05-ProbeLevel-CohortInfoRemoved-BonferroniAdded.txt.gz | \
    head -n 1 > eqtlgen_my_snps_final.txt
cat eqtlgen_my_snps.txt >> eqtlgen_my_snps_final.txt

echo "eQTL analysis complete"
cat eqtlgen_my_snps_final.txt
