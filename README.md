# Dissecting the Shared Genetic Architecture of Coronary Artery Disease and Rheumatoid Arthritis: A Multi-Omics Integrative Analysis

## Background
Epidemiological studies have established that autoimmune diseases significantly elevate cardiovascular disease risk, yet the shared genetic mechanisms remain poorly understood. This project implements a systematic multi-omics framework to identify shared causal variants, characterize their regulatory potential, and provide functional validation through independent expression datasets.

## Highlights
- Integrated GWAS summary statistics from 2 large-scale studies (n > 1,000,000 for CAD; n > 275,000 for RA)
- Identified 160 shared genome-wide significant loci (p < 5×10⁻⁸)
- Functionally annotated shared loci using H3K27ac ChIP-seq data from ENCODE across 2 immune-relevant cell types
- Narrowed to 15 high-confidence regulatory SNPs active in both CD4+ T cells and CD14+ monocytes
- Validated functional consequence of top candidates using eQTLGen (n = 31,684 whole blood samples), identifying 3 significant cis-eQTLs for HLA-C (FDR = 0, Z = 47.62)

## Tools and Technologies
| Category | Tools |
|---|---|
| Command Line | bash, awk, grep, sort, bedtools v2.30.0 |
| Languages | Python 3.9.21, R 4.3.x |
| Databases | EBI GWAS Catalog, ENCODE, UCSC Genome Browser, eQTLGen |
| Genome Build | GRCh37/hg19 |

## Analysis Pipeline

### Phase 1 — GWAS Integration
- Downloaded and processed GWAS summary statistics for CAD (GCST90132314, Aragam et al. 2022) and RA (GCST90132223, Ishigaki et al. 2022) from EBI GWAS Catalog
- Applied genome-wide significance threshold (p < 5×10⁻⁸) yielding 18,349 CAD and 35,227 RA significant variants
- Converted to BED format and identified 160 shared significant SNPs using coordinate-based intersection

### Phase 2 — Gene Annotation and Prioritization
- Downloaded RefGene annotation (hg19) from UCSC Genome Browser
- Performed closest-gene analysis using bedtools closest
- Prioritized genes by SNP density — top hits: HLA-B (29 SNPs), HLA-DRB1 (28 SNPs), HLA-DQA1 (19 SNPs)
- Identified 47 SNP-gene pairs with distance = 0 (SNP inside gene)

### Phase 3 — Regulatory Annotation via ChIP-seq
- Obtained H3K27ac ChIP-seq narrowPeak files from ENCODE for:
  - CD4+ alpha beta T cells (ENCFF347ILA)
  - CD14+ monocytes (ENCFF706YSV)
- Performed bedtools intersect to identify SNPs overlapping active enhancer/promoter regions
- 16/38 SNPs (42%) active in T cells; 17/38 SNPs (45%) active in monocytes
- 15 SNPs active in BOTH cell types — representing highest confidence shared regulatory variants

### Phase 4 — eQTL Validation
- Queried eQTLGen Phase 1 database (n = 31,684) for all 15 shared regulatory SNPs
- 3 SNPs identified as significant cis-eQTLs for HLA-C (FDR = 0 for all three):
  - rs9266196: Z = +47.62 (increases HLA-C expression)
  - rs9266144: Z = -23.48 (decreases HLA-C expression)  
  - rs697742: Z = -22.12 (decreases HLA-C expression)

## Key Biological Finding
15 shared CAD-RA SNPs concentrate in the HLA region on chromosome 6, overlapping active regulatory chromatin in immune-relevant cell types. 
Functional validation confirms these variants regulate HLA-C expression in whole blood, suggesting a shared immune-mediated regulatory mechanism underlying both diseases. Differential H3K27ac signal strength between T cells and monocytes indicates potential cell-type specific regulatory effects warranting further investigation.

## Repository Structure

```
GWAS-CAD-RA-Analysis/
│
├── scripts/
│   └── Scripts_run.md          # Complete documented pipeline
│
├── results/
│   ├── shared_snps.bed                        # 160 shared SNPs
│   ├── snps_inside_genes.txt                  # 47 SNP-gene pairs
│   ├── snps_for_chipseq.bed                   # 38 SNPs for ChIP-seq
│   ├── shared_regulatory_snps_annotated.txt   # 15 final SNPs
│   └── eqtlgen_my_snps_final.txt             # eQTL results
│
├── workflow/
│   └── Workflow.md             # Documented biological interpretation
│
└── README.md
```

## Data Availability
Raw GWAS summary statistics are publicly available from:
- CAD: https://www.ebi.ac.uk/gwas/studies/GCST90132314
- RA: https://www.ebi.ac.uk/gwas/studies/GCST90132223

ChIP-seq data available from ENCODE:
- ENCFF347ILA (CD4+ T cells)
- ENCFF706YSV (CD14+ monocytes)

eQTL data available from eQTLGen:
- https://eqtlgen.org/cis-eqtls.html
