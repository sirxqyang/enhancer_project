library(chipenrich)
#args <- commandArgs()
#filename <- args[6]
peaks_input <- read.table("matrix_nopromoter.bed", header=TRUE)

peakcall <- apply(peaks_input[,-c(1,2,3)], 1, paste, collapse="")
ES_specific <- peaks_input[peakcall=="11100000",][,1:3]
head(ES_specific)

colnames(ES_specific) <- c("chrom","start","end")
plot_dist_to_tss(peaks = ES_specific, genome = 'hg19')

results = chipenrich(peaks = ES_specific, 
                     locusdef = "nearest_tss", qc_plots = F,
                     genesets = c('biocarta_pathway'))
#results = chipenrich(peaks = ES_specific, 
#       locusdef = "nearest_tss", qc_plots = F,
#       genesets = c('GOBP', 'GOCC', 'GOMF', 'biocarta_pathway', 'kegg_pathway'))

gene <- read.table("chipenrich_peaks.tab", header=TRUE)
genesymbol <- unique(gene[,7])
genesymbol<-na.omit(genesymbol)
write.table(genesymbol, "genelist.txt", row.names = FALSE, col.names=FALSE, 
            quote=FALSE)

geneid <- unique(gene[,1])
geneid <- na.omit(geneid)
write.table(geneid, "geneidlist.txt", row.names = FALSE, col.names=FALSE, 
            quote=FALSE)