library(msa)
library(ggtree)
library(ggmsa)
library(ape)

##################### 进化树构建 ###############
file <- './03.pep.seq/WRKY.pep.renamed.fasta'
fasta <- readDNAStringSet(file)

alignment <- msa(fasta, method = 'ClustalW')

# 将比对结果转换为 XStringSet 对象
XStringSet <- as(alignment, "XStringSet")

# 相似性矩阵与进化树
my.alignment <- msaConvert(alignment, type = 'seqinr::alignment')
dist <- seqinr::dist.alignment(my.alignment, matrix = 'identity')

tree <- ape::njs(dist)  # 使用邻接法构建系统发育树
# plot(tree)
ape::write.tree(tree, file = "tree.nwk")

# 写入 FASTA 文件 
# writeXStringSet(XStringSet, "alignment.fasta")

################# 绘图 ##############
# 绘制进化树
options(ignore.negative.edge=TRUE)
p <- ggtree(tree, branch.length = 'none', layout = 'circular') +
  geom_treescale()

# 读取分组数据
p <- p %<+% group  # 将分组数据与树结合

# 添加分组颜色和注释
# p <- p + aes(color = Group) +
#   geom_tiplab(aes(color = Group), size = 1) +
#   theme(legend.position = c(0, 1),  # 设置图例位置为左上角
#         legend.justification = c(0, 1)) +
#   scale_color_manual(name = 'Class', 
#                      values = c("CNL" = "#1f78b4",
#                                 "NL" = "#ff7f00",
#                                 "RLP" = "#33a02c",
#                                 "CL" = "#fb9a99",
#                                 "N" = "#e31a1c",
#                                 "CN" = "#6a3d9a",
#                                 "L" = "#b2df8a",
#                                 "CNLK" = "#a6cee3"))
p <- p + aes(color = Type) +
  geom_tiplab(aes(color = Type), size = 2, linesize = 5) +
  theme(legend.position = c(0, 1),  # 设置图例位置为左上角
        legend.justification = c(0, 1)) +
  scale_color_manual(name = 'Type',
                     values = c("Type I" = "#1f78b4",
                                "Type II" = "#ff7f00",
                                "Type III" = "#33a02c"))
# 保存图形
ggsave("evolution_tree.pdf", plot=p, width=10, height=8, dpi=600)



