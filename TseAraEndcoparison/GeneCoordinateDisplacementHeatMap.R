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
  geneinfoDF2 <- geneinfoDF[!bad,]
  bad <- is.na(geneinfoDF2$araidentity)
  geneinfoDF3 <- geneinfoDF2[!bad,]
  #Difference between arabegin and tsebegin
  geneinfoDF3$tsebegin = as.integer(as.character(geneinfoDF3$tsebegin))
  geneinfoDF3$arabegin = as.integer(as.character(geneinfoDF3$arabegin))
  geneinfoDF3$araend = as.integer(as.character(geneinfoDF3$araend))
  geneinfoDF3$tseend = as.integer(as.character(geneinfoDF3$tseend))
  Fiveprimend = geneinfoDF3$tsebegin - geneinfoDF3$arabegin
  bad <- is.na(Fiveprimend)
  Fiveprimend <- Fiveprimend[!bad]
  #Difference between araend and tseend
  Threeprimend = geneinfoDF3$tseend - geneinfoDF3$araend
  bad <- is.na(Threeprimend)
  Threeprimend <- Threeprimend[!bad]
  
  par(mfrow = c(1, 1))
  X = Fiveprimend
  Y = Threeprimend
  data <- data.frame(X, Y)
  data = group_by(data, X, Y)
  data = summarize(data, frequency = n())
  data$frequency = data$frequency #/ sims
  xbreaks <- as.integer(levels(factor(X)))
  ybreaks <- as.integer(levels(factor(Y)))
  total <- sum(data$frequency)
  plottitle <- paste("Empirical joint distribution of end displacements of ", total, " TryTryp genes by two genefinders Aragorn and tRNAscan",sep = "")
  ggplot(data = data, aes(X, Y)) +
    geom_tile(aes(fill = frequency), color = "white") + geom_text(aes(label = frequency)) +
    scale_fill_gradient(low = "lightblue", high = "darkred", name = "frequency") +
    ggtitle(
      plottitle
    ) + 
    theme(plot.margin = unit(c(1.8, .5, 1.75, 1.55), "cm")) + theme(plot.title = element_text(
      color = "#383838",
      face = "bold",
      size = 17,
      vjust = 4,
      hjust = 0.5
    )) +
    theme(
      axis.title.x = element_text(
        color = "#383838",
        face = "bold",
        size = 13,
        vjust = -1.5
      ),
      axis.title.y = element_text(
        color = "#383838",
        face = "bold",
        size = 13,
        vjust = 2
      )
    ) +
    theme(
      axis.text.x = element_text(
        face = "bold",
        color = "#383838",
        size = 10
      ),
      axis.text.y = element_text(
        face = "bold",
        color = "#383838",
        size = 10
      )
    ) +
    xlab("5' (Tse-Ara)") + ylab("3' (Tse-Ara)") + scale_y_continuous(breaks = ybreaks) +
    scale_x_continuous(breaks = xbreaks)
  
  
}