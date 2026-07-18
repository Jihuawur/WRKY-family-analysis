library(tidyverse)
# 蛋白长度
pep.length <- read.table('./04.motif/protein.length', sep = '', header = T) %>% 
  pivot_longer(cols = c(start, end), values_to = 'position')

# 样品顺序
group %>% 
  group_by(Type) %>% 
  arrange(Type, geneID) %>%  
  ungroup %>% 
  pull(geneID) -> sample.order
pep.length$geneID <- factor(pep.length$geneID, levels = sample.order) 

# 构造geom_rect数据
result <- group %>%
  group_by(Type) %>%
  arrange(Type, geneID) %>% 
  summarize(First = first(geneID), Last = last(geneID))


# 画图
motif <- motif.position
f <- ggplot(data = pep.length) +
  geom_line(aes(x = position, y = geneID), color = "darkgray", size = 0.5) +
  geom_segment(data = motif, 
               aes(x = start, xend = end, 
                   y = geneID, yend = geneID, color = motif), size = 1.2) +
  theme_classic() +
  # scale_color_manual(name = "Motif Type", values = c("blue", "red")) +
  scale_x_continuous(expand = c(0.01, 0.01)) +
  theme(axis.text.y = element_text(size = 2.5, color = 'darkblue')) +
  geom_rect(data = result, 
            aes(xmin = 1, xmax = 1100, ymin = First, ymax = Last, 
            fill = Type),
            alpha = 0.1, inherit.aes = FALSE) +
  scale_fill_manual(values = c("Type I" = "#1f78b4",
                               "Type II" = "#ff7f00",
                               "Type III" = "#33a02c")) +
  labs(x='Length (bp)', y='Gene ID')


ggsave("motif.pdf", plot=f, width=10, height=8, dpi=300)
 
  

