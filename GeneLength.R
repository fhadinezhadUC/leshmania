geneseq<- read.table("/home/fatemeh/leshmania/genesequences.txt")
genelengths <- nchar(as.character(geneseq$V1))
large <- ( genelengths >= 100 & genelengths <= 120 ) 
verylarge <- genelengths > 120
small <- genelengths < 100
largegenesdf <- genelengths[large]
verylargegenedf <- genelengths[verylarge]
smallgenesdf <- genelengths[small]
par(mfrow=c(1,3))
plot(table(smallgenesdf), xlab = "gene length", ylab = "frequency", col = "darkblue")
plot(table(largegenesdf), xlab = "gene length", ylab = "frequency", col = "purple")
plot(table(verylargegenedf), xlab = "gene length", ylab = "frequency", col ="darkred")
title("Distribution of Tri-Tryp Gene Lengths", line = -2, outer = TRUE)

