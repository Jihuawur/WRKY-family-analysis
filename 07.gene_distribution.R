library(RIdeogram)

# karyotype
karyotype <- read.table('./07.gene.distribution/length.per.chromosome', col.names = c('Chr','Start','End'))
karyotype$Chr <- str_replace_all(karyotype$Chr, 'Chr', '')

# target gene information
gene.label <- read.table('./07.gene.distribution/adj.cds.map.txt', 
                         col.names = c('Chr', 'Gene', 'Start', 'End'))
gene.label$Chr <- str_replace_all(gene.label$Chr, 'Chr', '')
# id转换
id2id <- read.table('OriginID.geneID.txt', sep = '',
           col.names = c('geneID','Gene'))
gene.label <- gene.label %>% left_join(id2id, by = 'Gene') %>% 
  select(Chr, geneID, Start, End)

# WRKY类型
# group

# gene density
gene.density <- gene.label
gene.density$Value <- 1
gene.density <- gene.density[,c('Chr','Start','End','Value')]
# 作图
gene.info <- group %>%
  right_join(gene.label, by = 'geneID') %>%
  mutate(color = case_when(Type == "Type I" ~ "1f78b4",
                           Type == "Type II" ~ "ff7f00",
                           Type == "Type III" ~ "33a02c"),
         Shape = case_when(Type == "Type I" ~ "circle",
                           Type == "Type II" ~ "box",
                           Type == "Type III" ~ "triangle")
                           )
gene.info <- gene.info %>% select(Type, Shape, Chr, Start, End, color)

# 舍弃不在染色体上的基因
density.label <- gene.density[!grepl('tig', gene.density$Chr),]
type.label <- gene.info[!grepl('tig', gene.info$Chr),]

# 绘制成两幅图,映射数据为density.lable和type.label
ideogram(karyotype = karyotype[1:30,],
            overlaid = density.label,
            colorset1 = 'blue',
            label = type.label,
            label_type = 'marker',
            Lx=8, # legend position
            Ly=2.5,
            width = 180,
            output = 'Camellia_1.svg')

convertSVG("Camellia_1.svg", file = 'Camellia_1', device = "png",
           width = 14, height = 15, dpi = 300)
convertSVG("Camellia_1.svg", file = 'Camellia_1', device = "pdf",
           width = 14, height = 15, dpi = 300)

ideogram(karyotype = karyotype[30:60,],
         overlaid = density.label,
         colorset1 = 'blue',
         label = type.label,
         label_type = 'marker',
         # Lx=NULL,
         # Ly=NULL,
         Lx=220, # legend position
         Ly=1.5,
         width = 180,
         output = 'Camellia_2.svg')

convertSVG("Camellia_2.svg", file = 'Camellia_2', device = "png",
           width = 14, height = 15, dpi = 300)
convertSVG("Camellia_2.svg", file = 'Camellia_2', device = "pdf",
           width = 14, height = 15, dpi = 300)
