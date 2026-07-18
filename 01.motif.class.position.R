setwd("~/bioinfo/seq.analysis/WRKY")

motif.scan <- read.table('./04.motif/WRKY.pep.renamed.fasta.tsv', sep = '\t')
zinc.scan <- read.csv('./04.motif/wrky_classification_with_positions.csv', header = T)

# motif位置
pfam.motif <- motif.scan %>% 
  filter(V4=='Pfam' & V5=='PF03106') %>% 
  select(geneID=V1,
         model=V5,
         start=V7,
         end=V8,
         motif=V13)

zinc.motif <- zinc.scan %>% 
  select(geneID=SequenceID,
         model=Pattern,
         start=Start,
         end=End) %>% 
  mutate(motif='Zinc Finger')

motif.position <- rbind(pfam.motif, zinc.motif)


# motif分类
zinc.group <- zinc.scan %>% 
  select(geneID=SequenceID,
         Type=Type) %>% unique

geneID <- unique(motif.position$geneID)
group <- data.frame(geneID=geneID, Type='')
keep <- group$geneID %in% zinc.group$geneID

group[!keep,]$Type <- 'Type I'
group <- group[group$Type!='',]
group <- rbind(group, zinc.group)


