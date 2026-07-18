#!/bin/sh
## align reads to reference genome
# usage:
# bash <file.sh> <file.list> <indexed reference genome> <INDIR> <OUTDIR>

fqFILE=$1
REF=$2
INDIR=$3
OUTDIR=$4

# 检查索引文件是否存在
if [ ! -e "${REF}.bwt" ]; then
    echo "错误: 索引文件 ${REF}.bwt 不存在！"
    exit 1
fi

## declare variables
while read ID
do
FORWARD=${INDIR}/${ID}_1.trimmed.fastq.gz
REVERSE=${INDIR}/${ID}_2.trimmed.fastq.gz
OUTPUT=${ID}_sort.bam


## then align and sort
echo "Aligning $ID with bwa"
bwa mem -M -t 8 -v 2 $REF $FORWARD $REVERSE \
| samtools view -b \
| samtools sort -T ${ID} -o "${OUTPUT}"

done < $fqFILE