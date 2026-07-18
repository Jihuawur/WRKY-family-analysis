# WRKY-family-analysis
Characterizing WRKY gene family in Camellia oleifera genome
# Genome-Wide Identification and Functional Analysis of WRKY Transcription Factors in *Camellia oleifera*

[![DOI](https://zenodo.org/badge/占位符.svg)](占位符)
[![GitHub release](https://img.shields.io/github/release/用户名/仓库名.svg)](https://github.com/用户名/仓库名/releases)

This repository contains the custom scripts and analytical pipelines used in the study:

&gt; **"Genome-Wide Identification and Functional Analysis of WRKY Transcription Factors in Tetraploid *Camellia oleifera* Highlights a Key Regulator of Anthracnose Resistance"**

## 📋 Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Directory Structure](#directory-structure)
- [Scripts Description](#scripts-description)
  - [1. WRKY Gene Identification](#1-wrky-gene-identification)
  - [2. Gene Structure and Domain Analysis](#2-gene-structure-and-domain-analysis)
  - [3. Chromosomal Localization](#3-chromosomal-localization)
  - [4. Phylogenetic Analysis](#4-phylogenetic-analysis)
  - [5. RNA-Seq Data Preprocessing](#5-rna-seq-data-preprocessing)
  - [6. Read Mapping and Quantification](#6-read-mapping-and-quantification)
  - [7. Differential Expression Analysis](#7-differential-expression-analysis)
  - [8. Functional Annotation and Enrichment](#8-functional-annotation-and-enrichment)
- [Usage](#usage)
- [Data Availability](#data-availability)
- [Citation](#citation)
- [Contact](#contact)

---

## 🔬 Overview

This project provides a complete bioinformatics workflow for:
- Genome-wide identification and classification of WRKY transcription factors in tetraploid *Camellia oleifera*
- Comparative transcriptomic analysis of anthracnose-resistant (CL150) and susceptible (CL102) cultivars
- Functional annotation and enrichment analysis of differentially expressed genes

All scripts are designed to run on Linux-based HPC clusters and have been tested on CentOS 7.9.

---

## 💻 System Requirements

### Hardware
- Linux-based HPC cluster or workstation with ≥ 16 CPU cores
- RAM: ≥ 64 GB recommended for polyploid genome mapping
- Storage: ≥ 200 GB free space

### Software Dependencies

| Software | Version | Purpose |
|----------|---------|---------|
| HMMER | 3.3.2 | WRKY domain search |
| NCBI BLAST+ | 2.12.0+ | Homology verification |
| InterProScan | 5.52-86.0 | Domain annotation |
| fastp | 0.23.2 | Read QC and trimming |
| BWA-MEM | 0.7.17 | Read alignment |
| SAMtools | 1.15 | BAM processing |
| Picard | 2.27.5 | Duplicate removal |
| featureCounts | 2.0.1 | Gene expression quantification |
| R | ≥ 4.0.5 | Statistical analysis |
| Python | ≥ 3.8 | Auxiliary scripts |

### R Packages
```r
install.packages(c("DESeq2", "clusterProfiler", "ggplot2", "pheatmap", "RColorBrewer", "dplyr"))
# Bioconductor packages
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("DESeq2", "clusterProfiler", "org.At.eg.db"))
