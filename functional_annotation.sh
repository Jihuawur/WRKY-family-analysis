# interproscan
# OUTFILE=newheader.DEG.109.pep.fasta.tsv
PROG="/home/data/t060648/my_interproscan/interproscan-5.73-104.0"
"${PROG}"/interproscan.sh -i newheader.DEG.109.pep.fasta -f tsv -goterms -pa

# EGG-NOG
conda create -n eggnog_mapper python=3.8 -y
conda activate eggnog_mapper
conda install -c bioconda eggnog_mapper
download_eggnog_data.py

# OUTFILE output.emapper.annotations
db='~/miniconda/envs/eggnog_mapper/lib/python3.8/site-packages/data'
nohup emapper.py -i newheader.DEG.109.pep.fasta \
-o output --cpu 16 &
