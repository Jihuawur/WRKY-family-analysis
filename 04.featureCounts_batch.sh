#!/bin/bash
# 用法: bash script.sh <GTF> <OUTDIR> <BAM_DIR> <THREADS_PER_JOB>

GTF=$1
OUTDIR=$(realpath "$2") 
BAM_DIR=$3
THREADS=${4:-4}

# 检查并创建输出目录（无论是否存在都执行，-p参数会自动忽略已存在的目录）
mkdir -p "$OUTDIR"

# 检查输入文件是否存在
if [[ ! -f "$GTF" ]]; then
    echo "Error: GTF file $GTF not found!" >&2
    exit 1
fi

if [[ ! -d "$BAM_DIR" ]]; then
    echo "Error: BAM directory $BAM_DIR not found!" >&2
    exit 1
fi

# 并行处理所有BAM文件（GNU Parallel）
#parallel -j 4 "featureCounts -T $THREADS -p --countReadPairs -t exon -g gene_id \
#    -a $GTF -o $OUTDIR/{/.}.txt {}" ::: "$BAM_DIR"/*.bam

# 或使用循环（无并行）
for BAM in "$BAM_DIR"/*.bam; do
    BASE=$(basename "$BAM" .bam)
    echo "Processing $BASE..."

    featureCounts -T $THREADS -p --countReadPairs -t exon -g gene_id \
        -a "$GTF" -o "$OUTDIR/${BASE}_counts.txt" "$BAM"
done

echo "Analysis completed. Results saved to $OUTDIR"