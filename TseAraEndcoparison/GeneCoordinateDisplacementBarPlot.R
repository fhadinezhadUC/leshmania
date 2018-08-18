GeneCoordinateDisplacement <- function() {
  name <-
    read.table(
      "/home/fatemeh/leshmania/mainfolder/geneinfoDFFirstDraft.txt",
      nrows = 1 ,
      col.names = TRUE
    )
  geneinfoDF <-
    read.table("/home/fatemeh/leshmania/mainfolder/geneinfoDFFirstDraft.txt",
               skip = 1)
  name <- as.vector(name$TRUE.)
  names(geneinfoDF) <- name
  bad <- is.na(geneinfoDF$tseidentity)
  geneinfoDF2 <- geneinfoDF[!bad, ]
  bad <- is.na(geneinfoDF2$araidentity)
  geneinfoDF3 <- geneinfoDF2[!bad, ]
  #Difference between arabegin and tsebegin
  geneinfoDF3$tsebegin = as.integer(as.character(geneinfoDF3$tsebegin))
  geneinfoDF3$arabegin = as.integer(as.character(geneinfoDF3$arabegin))
  geneinfoDF3$araend = as.integer(as.character(geneinfoDF3$araend))
  geneinfoDF3$tseend = as.integer(as.character(geneinfoDF3$tseend))
  Fiveprimend = geneinfoDF3$tsebegin - geneinfoDF3$arabegin
  bad <- is.na(Fiveprimend)
  Fiveprimend <- Fiveprimend[!bad]
  #Difference between araend and tseend
  Threeprimend = geneinfoDF3$araend - geneinfoDF3$tseend
  bad <- is.na(Threeprimend)
  Threeprimend <- Threeprimend[!bad]
  Displacements <- paste(Fiveprimend, Threeprimend, sep = "-")
  
  #plot(table(Displacements))
  pieDF <- table(Displacements)
  pieDF <- as.data.frame(pieDF)
  pieDF <- pieDF[order(pieDF$Freq),]
  pieDF$percentage <-
    paste0(round(pieDF$Freq / sum(pieDF$Freq) * 100, 2), "%")
  cols <- rainbow(nrow(pieDF))
  pieDF$Displacements <-
    factor(pieDF$Displacements, levels = pieDF$Displacements)
  g <-
    ggplot(pieDF, aes(x = pieDF$Displacements, y = pieDF$Freq)) + geom_bar(stat = "identity", fill = cols)
  g + geom_text(
    aes(label = pieDF$percentage),
    vjust = -.5,
    size = 3,
    col = "darkblue"
  ) + xlab("5'TseAraDifference-3'AraTseDifference") + ylab("Frequency") + ggtitle("TryTryp Gene Coordinate-Displacement")+theme(plot.title = element_text(hjust = 0.5))
  
}