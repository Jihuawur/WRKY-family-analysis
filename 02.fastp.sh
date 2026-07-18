#!/bin/bash
# quality control for fastq files
# usage:
# bash <file.sh> <fastq.file.list> <outdir>

fqFILE=$1
OUTDIR=$2


while read FILE; do

echo 'starting to process "${FILE}"...'
fastp -i "${FILE}"_1.fastq.gz \
-I "${FILE}"_2.fastq.gz \
-o "${OUTDIR}"/"${FILE}"_1.trimmed.fastq.gz \
-O "${OUTDIR}"/"${FILE}"_2.trimmed.fastq.gz \
-h -R "rnaseq.fastp" -w 8

echo '"${FILE}" DONE'

done < ${fqFILE}

echo 'fastp completed'