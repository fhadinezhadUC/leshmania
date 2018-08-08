findPos73 <- function() {
  # read file seqDB.txt
  # read file info.txt
  seqDB <-
    read.table("/home/fatemeh/leshmania/mainfolder/intronFrequency/seqDB.txt",
               sep = " ")
  info <-
    read.table("/home/fatemeh/leshmania/mainfolder/CCAtemplates/equaldf.txt")
  geneindex = 0
  pos73index = 0
  info$V2 <- as.character(info$V2)
  # an one column for pos73index
  info$pos73index = 0
  pos73ind = 0
  coveapos73marker = 0
  for (j in 1:length(info$V2)) {
    for (i in 1:length(genesIDs)) {
      if (genesIDs[i] == info$V2[j])
      {
        geneindex = i
        break
      }
    }
    
    # look for the last capital letter in column geneindex
    # for (i in 1:nrow(seqDB)) {
    #   if (seqDB[i, geneindex] == "A" |
    #       seqDB[i, geneindex] == "C" |
    #       seqDB[i, geneindex] == "G" | seqDB[i, geneindex] == "T")
    #     coveapos73marker = i
    #
    # }
    # I know it is at position 976 so coveapos73marker = 976
    coveapos73marker = 976
    for (i in 1:coveapos73marker) {
      if (seqDB[i, geneindex] == "A" |
          seqDB[i, geneindex] == "C" |
          seqDB[i, geneindex] == "G" |
          seqDB[i, geneindex] == "T" |
          seqDB[i, geneindex] == "N" |
          seqDB[i, geneindex] == "a" |
          seqDB[i, geneindex] == "c" |
          seqDB[i, geneindex] == "g" |
          seqDB[i, geneindex] == "t" | seqDB[i, geneindex] == "n")
        pos73ind = pos73ind + 1
    }
    info$pos73index[j] = pos73ind
    pos73ind = 0
  }
  
  write.table(info, file = "/home/fatemeh/leshmania/mainfolder/CCAtemplates/info2.txt", sep = " ")
  
  # Then, make a nother data frame called Next50DF with columns: "geneID" "geneSeqUpTo73" "next50bp" "strand"
  # For each gene sequence take up to position 73 index info2$pos73index and put it in geneSeqUpTo73 column.
  m <- matrix(ncol = 4 , nrow = nrow(info))
  Next50DF <- as.data.frame(m)
  names(Next50DF) <- c("geneID", "geneSeqUpTo73", "next50bp", "strand")
  Next50DF$geneID <- info$V2
  Next50DF$strand <- info$V5
  Next50DF$geneID <- as.character(Next50DF$geneID)
  Next50DF$geneSeqUpTo73 <- as.character(Next50DF$geneSeqUpTo73)
  Next50DF$next50bp <- as.character(Next50DF$next50bp)
  Next50DF$strand <- as.character(Next50DF$strand)
  Next50DF$geneSeqUpTo73 <- substring(info$V3, 1, info$pos73index)
  
  remain <- substring(info$V3, info$pos73index + 1)
  
  # paste the remain with the rest of the 50 and put it in next 50bp (if the direction is reverse, reverse complement the next50 first)
  for (i in 1:nrow(info)) {
    if (info$V5[i] == "reverse")
    {
      myseq <- info$V6[i]
      myseqc <- chartr("ATGCNnatgc", "TACGNntacg", myseq)
      myseqrevc <-
        paste(rev(unlist(strsplit(myseqc, NULL))), collapse = "")
      Next50DF$next50bp[i] <- paste(remain[i], myseqrevc, sep = "")
    }
    if (info$V5[i] == "forward")
    {
      Next50DF$next50bp[i] <- paste(remain[i], info$V6[i], sep = "")
    }
  }
  write.table(Next50DF,file = "/home/fatemeh/leshmania/mainfolder/CCAtemplates/Next50bp.txt")
}
