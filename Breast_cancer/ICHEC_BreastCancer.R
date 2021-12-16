## Voom analysis of breast cancer data becvcause it takes shit loads of time
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("limma")
library(limma)

Table_final_results <- readRDS("BreastCancer/TCGA_expression_table_reads.rds")

expression_matrix <- t(as.matrix(Table_final_results[,1:20281]))

# apply voom
pdf("Voom.pdf", width = 10)
voom.analysis=voom(expression_matrix, plot=TRUE, normalize.method = "quantile")
dev.off()

Voom_table <- merge(as.data.frame(t(voom.analysis$E)), Table_final_results[,20282:20285], by=0)
rownames(Voom_table) <- Voom_table[,1]
Voom_table = Voom_table[,-1]
save.image("VoomTable.RData")