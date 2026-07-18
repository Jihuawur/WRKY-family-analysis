library(tidyverse)
library(patchwork)
# 基因结构数据
gene.structure <- read.table('./06.gene.structure/WRKY.structure.txt', sep = '', 
                         col.names = c('Gene','Type','Start','End'))
dat <- gene.structure

# 按wrky类型排序
group %>% 
  group_by(Type) %>% 
  arrange(Type, geneID) %>%  
  ungroup %>% 
  pull(geneID) -> sample.order

dat <- dat %>% 
  mutate(geneID = factor(Gene, levels = sample.order))

# 其实位置归一化，即忽略基因间的相对位置
dat <- dat %>% 
  group_by(Gene) %>% 
  mutate(min_start=min(Start)) %>%
  ungroup
dat <- dat %>% 
  mutate(Relative_start=Start-min_start,
         Relative_end=End-min_start)

# 基因起始位置
gene <- dat[dat$Type=='mRNA',]
cds <- dat[dat$Type!='mRNA',]
# cds <- dat[dat$Type=='CDS',]
# utr <- dat[grepl('UTR', dat$Type),]

# 作图
fig.gene <- ggplot(data = gene) +
  geom_segment(aes(x = Relative_start, xend = Relative_end, y = Gene, yend = Gene), color = "darkgray", size = 0.5) +
  geom_segment(data = cds, 
               aes(x = Relative_start, xend = Relative_end, 
                   y = Gene, yend = Gene, color = Type), size = 1.2) +
  theme_classic() +
  scale_x_continuous(expand = c(0.01, 0.01)) +
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank()) +
  labs(x = 'Length (bp)')

ggsave("gene_structure.pdf", plot=fig.gene, width=10, height=8, dpi=300)

# 合并motif图和基因结构图，并导出为pdf
pdf('Fig2.gene_structure.pdf', width = 14, height = 9)
f + fig.gene + 
  plot_layout(ncol=2) + plot_annotation(tag_levels = "a",
                                        theme = theme(
                                          plot.tag = element_text(family = 'Times New Roman', face = 'bold'),
                                          plot.tag.position = c(0.01, 0.99))) 
dev.off()

