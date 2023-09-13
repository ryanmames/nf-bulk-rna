library(edgeR)

args <- commandArgs(trailingOnly = TRUE)
counts.file <- args[1]
meta.file <- args[2]
control.condition <- args[3]
contrast.condition <- args[4]

print("Reading data...")
counts <- read.csv(counts.file, header = TRUE, row.names = 1)
meta <- read.csv(meta.file, header = TRUE, row.names = 1)

# Get the samples
samples <- colnames(counts)

# select metadata for the existing samples from all count data
meta <- meta[intersect(rownames(meta), unique(samples)),]

# Reorder the counts matrix to have the same order as rows in meta data
counts <- counts[, row.names(meta)]

# Create the DGE object
print("Creating DGE object...")
dge <- DGEList(counts = counts, group = meta$Sample.Group)

# Filter the data (CPM > 1 (counts > 6-7), expression in at least 2 samples per group, recalculate library sizes)
print("Filtering on CPM...")
keep <- filterByExpr(dge, group = meta$Sample.Group)
dge <- dge[keep, , keep.lib.sizes = FALSE]

# Normalise 
dge <- calcNormFactors(dge)
dge <- estimateCommonDisp(dge)
dge <- estimateTagwiseDisp(dge)

# Calculate differential expression
et <- exactTest(dge, pair = c(control.condition, contrast.condition))
et$table$FDR <- p.adjust(et$table$PValue, method = "BH")
write.table(et$table, file = "differential_expression.tsv", sep = "\t", quote = FALSE)
write.table(et$table[et$table$FDR <= 0.05, ], file = "differential_expression_significant.tsv", sep = "\t", quote = FALSE)

pdf("mean-difference.pdf")
plotMD(et)
