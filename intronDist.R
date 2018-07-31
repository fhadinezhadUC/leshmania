
intronDist <- function() {
  # library(proto)
  # library(gsubfn)
  # startline = 3282
  # read the whole CS lines into an array called CS
  seqDB <- readSeqsIntoDf()
  seqDB <- assignLocation(seqDB)
  
  ### arm locations ###
  intronM <- matrix(ncol = 3 , nrow = 1)
  intronDf <- as.data.frame(intronM)
  names(intronDf) <- c("seqname", "sequence", "Location")
  
  # from location 1 to 7
  start <- match(1, seqDB$Location)
  end <- match(7, seqDB$Location)
  arrow = ">"
  intronDf <- armIntron(seqDB, intronDf, start, end, arrow)
  # from location 10 to 13
  start <- match(10, seqDB$Location)
  end <- match(13, seqDB$Location)
  arrow = ">"
  intronDf <- armIntron(seqDB, intronDf, start, end, arrow)
  # from location 22 to 25
  start <- match(22, seqDB$Location)
  end <- match(25, seqDB$Location)
  arrow = "<"
  intronDf <- armIntron(seqDB, intronDf, start, end, arrow)
  # from location 27 to 31
  start <- match(27, seqDB$Location)
  end <- match(31, seqDB$Location)
  arrow = ">"
  intronDf <- armIntron(seqDB, intronDf, start, end, arrow)
  # from location 39 to 43
  start <- match(39, seqDB$Location)
  end <- match(43, seqDB$Location)
  arrow = "<"
  intronDf <- armIntron(seqDB, intronDf, start, end, arrow)
  # from location 49 to 53
  start <- match(49, seqDB$Location)
  end <- match(53, seqDB$Location)
  arrow = ">"
  intronDf <- armIntron(seqDB, intronDf, start, end, arrow)
  # from location 61 to 72
  start <- match(61, seqDB$Location) ## ??
  end <- match(72, seqDB$Location)
  arrow = "<"
  intronDf <- armIntron(seqDB, intronDf, start, end, arrow)
  
  ### loop locations ###
  # from location 7 to 10
  start <- match(7, seqDB$Location)
  start <- start + 1
  end <- match(10, seqDB$Location)
  end <- end - 1
  intronDf <- loopIntron(seqDB, intronDf, start, end)
  # from location 13 to 22
  start <- match(13, seqDB$Location)
  start <- start + 1
  end <- match(22, seqDB$Location)
  end <- end - 1
  intronDf <- loopIntron(seqDB, intronDf, start, end)
  # from location 25 to 27
  start <- match(25, seqDB$Location)
  start <- start + 1
  end <- match(27, seqDB$Location)
  end <- end - 1
  intronDf <- loopIntron(seqDB, intronDf, start, end)
  # from location 31 to 39 where we have more introns
  start <- match(31, seqDB$Location)
  start <- start + 1
  end <- match(39, seqDB$Location)
  end <- end - 1
  intronDf <- loopIntron(seqDB, intronDf, start, end)
  # # from location 43 to 49 variable length arm
  # start <- match(43, seqDB$Location)
  # start <- start + 1
  # end <- match(49, seqDB$Location)
  # end <- end - 1
  # intronDf <- loopIntron(seqDB, intronDf, start, end)
  # from location 53 to 61
  start <- match(53, seqDB$Location)
  start <- start + 1
  end <- match(61, seqDB$Location)
  end <- end - 1
  intronDf <- loopIntron(seqDB, intronDf, start, end)
  
  ###################################################################################  
  
  intronlengths <- nchar(intronDf$sequence)
  largeintrons <- intronlengths > 100
  smallintrons <- intronlengths < 100
  large <- intronlengths[largeintrons]
  small <- intronlengths[smallintrons]
  par(mfrow=c(1,2))
  plot(table(large), xlab = "Intron Length", ylab = "Frequency", col = "darkblue")
  plot(table(small), xlab = "Intron Length", ylab = "Frequency", col = "darkred")
  title("Distribution of Intron Lengths in Tri-Tryp tRNA Genes", line = -2, outer = TRUE)
  
  par(mfrow=c(1,1))
  isintron <- nchar(intronDf$sequence)>3
  newdf<- intronDf[isintron,]
  plot(table(newdf$Location), xlab = "Intron Location on tRNA", ylab = "Frequency", col = "darkblue",main = "Distribution of intron (with length > 3) Locations on Tri-Tryp tRNA Genes ")
 
  ###################################################################################  
  
  intronDf
}
#####################################################################################
armIntron <- function(seqDB, intronDf, start, end, arrow) {
  # define the data frame for introns
  # 3 columns: "seqname" "sequence" "Location"
  #arrow = ">"
  tempintronM <- matrix(ncol = 3 , nrow = 1)
  tempintronDf <- as.data.frame(tempintronM)
  intronindex = 1
  names(tempintronDf) <- c("seqname", "sequence", "Location")
  armdf <- seqDB[start:end,]
  breakindex = 0
  intron = ""
  j = 0
  intronlocation = 0
  for (i in 1:ncol(armdf)) {
    intronlocation = 0
    breakindex = 0
    intron = ""
    j = 0
    while (j < nrow(armdf)) {
      j = j + 1
      if (armdf[j, i] == "a" |
          armdf[j, i] == "c" |
          armdf[j, i] == "g" | armdf[j, i] == "t")
      {
        if (armdf$CS[j] != arrow)
        {
          intron = armdf[j, i]
          for (t in (j + 1):nrow(armdf)) {
            if (armdf$CS[t] == arrow)
            {
              breakindex = t + 1
              intronlocation = armdf$Location[t] - 1  ### neeewwww
              break
            }
            if (armdf[t, i] == "a" |
                armdf[t, i] == "c" |
                armdf[t, i] == "g" | armdf[t, i] == "t")
            {
              intron <- paste(intron, armdf[t, i], sep = "")
            }
          }
          # now we need to set j to the last t
          if (breakindex != 0)
            j = breakindex
          if (breakindex == 0)
          {
            j = nrow(armdf)
            intronlocation =  seqDB$Location[end]
          }
          
          breakindex = 0
          if (nchar(intron) > 0)
          {
            tempintronDf$seqname[1] <- names(armdf)[i]
            tempintronDf$sequence[1] <- intron
            #set the location of intron later
            tempintronDf$Location[1] <- intronlocation
            intron = ""
            intronDf <- rbind(tempintronDf, intronDf)
            #intronindex = intronindex + 1
          }
        }
      }
    }
  }
  intronDf
}
#####################################################################################
loopIntron <- function(seqDB, intronDf, start, end) {
  {
    tempintronM <- matrix(ncol = 3 , nrow = 1)
    tempintronDf <- as.data.frame(tempintronM)
    intronindex = 1
    names(tempintronDf) <- c("seqname", "sequence", "Location")
    loopdf <- seqDB[start:end,]
    breakindex = 0
    intron = ""
    j = 0
    locationcounter = 0
    intronlocation = 0
  }
  for (i in 1:ncol(loopdf)) {
    locationcounter = 0
    intronlocation = 0
    breakindex = 0
    intron = ""
    j = 0
    while (j < (nrow(loopdf))) {
      #for (j in 1:nrow(loopdf))
      j = j + 1
      ## just for finding the location
      if (loopdf[j, i] == "A" |
          loopdf[j, i] == "C" |
          loopdf[j, i] == "G" | loopdf[j, i] == "T")
      {
        locationcounter = locationcounter + 1
      }
      if (loopdf[j, i] == "a" |
          loopdf[j, i] == "c" |
          loopdf[j, i] == "g" | loopdf[j, i] == "t")
      {
        intron = loopdf[j, i]
        countbase = 1
        for (t in (j + 1):nrow(loopdf)) {
          if (loopdf[t, i] == "A" |
              loopdf[t, i] == "C" |
              loopdf[t, i] == "G" | loopdf[t, i] == "T")
          {
            breakindex = t + 1
            intronlocation = locationcounter + seqDB$Location[start - 1]
            locationcounter = locationcounter + 1
            break
          }
          if (loopdf[t, i] == "a" |
              loopdf[t, i] == "c" |
              loopdf[t, i] == "g" | loopdf[t, i] == "t")
          {
            intron <- paste(intron, loopdf[t, i], sep = "")
          }
        }
        # now we need to set j to the last t
        if (breakindex != 0)
          j = breakindex
        if (breakindex == 0)
        {
          j = nrow(loopdf)
          intronlocation = locationcounter + seqDB$Location[start - 1]
        }
        breakindex = 0
        if (nchar(intron) > 0)
        {
          tempintronDf$seqname[1] <- names(loopdf)[i]
          tempintronDf$sequence[1] <- intron
          #set the location of intron later
          tempintronDf$Location[1] <- intronlocation
          intron = ""
          intronDf <- rbind(tempintronDf, intronDf)
          #intronindex = intronindex + 1
        }
        
      }
      
    }
  }
  intronDf
  
}
#####################################################################################
assignLocation <- function(seqDB) {
  #breaks <- integer(length = 12)
  locations <- integer(length = nrow(seqDB))
  count = 0
  index = 0
  for (i in 1:nrow(seqDB)) {
    if (seqDB$CS[i] == ">") {
      count = count + 1
      locations[i] = count
    }
    if (count == 7)
    {
      index = i
      break
      
    }
  }
  
  loc = 9
  count = 0
  for (i in (index + 1):nrow(seqDB)) {
    if (seqDB$CS[i] == ">") {
      loc = loc + 1
      locations[i] = loc
      count = count + 1
    }
    if (count == 4)
    {
      index = i
      break
      
    }
  }
  
  loc = 21
  count = 0
  for (i in (index + 1):nrow(seqDB)) {
    if (seqDB$CS[i] == "<") {
      loc = loc + 1
      locations[i] = loc
      count = count + 1
    }
    if (count == 4)
    {
      index = i
      break
      
    }
  }
  
  count = 0
  loc = 26
  
  for (i in (index + 1):nrow(seqDB)) {
    if (seqDB$CS[i] == ">") {
      loc = loc + 1
      locations[i] = loc
      count = count + 1
    }
    if (count == 5)
    {
      index = i
      break
      
    }
  }
  
  loc = 38
  count = 0
  for (i in (index + 1):nrow(seqDB)) {
    if (seqDB$CS[i] == "<") {
      loc = loc + 1
      locations[i] = loc
      count = count + 1
    }
    if (count == 5)
    {
      index = i
      break
      
    }
  }
  loc = 48
  count = 0
  for (i in (index + 1):nrow(seqDB)) {
    if (seqDB$CS[i] == ">") {
      loc = loc + 1
      locations[i] = loc
      count = count + 1
    }
    if (count == 5)
    {
      index = i
      break
      
    }
  }
  
  loc = 60
  count = 0
  for (i in (index + 1):nrow(seqDB)) {
    if (seqDB$CS[i] == "<") {
      loc = loc + 1
      locations[i] = loc
      count = count + 1
    }
    if (count == 12)
    {
      index = i
      break
      
    }
  }
  seqDB$Location <- locations
  seqDB
}


#####################################################################################
# # of columns in the dataframe is: # of sequences + 1 CS line
# name of the columns are "CS","seqname1", "seqname2", ...
readSeqsIntoDf <- function()
{
  CS <-
    grep(
      "#=CS +",
      readLines(
        "/home/fatemeh/leshmania/mainfolder/TryTrypDB_Aug2017_alltRNAs.tfam.covea"
      ),
      value = TRUE
    )
  temp <-
    unlist(strsplit(CS, split = "                                                         "))
  CS <- temp[seq(2, 34, 2)]
  CS <- paste(CS, collapse = '')
  CSarr <- substring(CS, seq(1, nchar(CS), 1), seq(1, nchar(CS), 1))
  
  # read the name of the sequences into variable "seqnames"
  SQs <- grep(
    "#=SQ +",
    readLines(
      "/home/fatemeh/leshmania/mainfolder/TryTrypDB_Aug2017_alltRNAs.tfam.covea"
    ),
    value = TRUE
  )
  seqnames <- character(length = length(SQs))
  for (i in 1:length(SQs)) {
    seqnames[i] <- unlist(strsplit(SQs[i], split = " "))[2]
  }
  
  # define the main data frame as "seDB" and assign names to it
  m <- matrix(ncol = (length(seqnames) + 1), nrow = length(CSarr))
  seqDB  <- as.data.frame(m)
  names(seqDB) <- c(seqnames, "CS")
  
  for (i in 1:length(seqnames)) {
    pat <- paste("^", seqnames[i], " +", sep = "")
    myseq <-
      grep(
        pattern = pat,
        readLines(
          "/home/fatemeh/leshmania/mainfolder/TryTrypDB_Aug2017_alltRNAs.tfam.covea"
        ),
        value = TRUE
      )
    temp <-
      unlist(strsplit(myseq, split = " +"))
    myseq <- temp[seq(2, 34, 2)]
    myseq <- paste(myseq, collapse = '')
    myseqarr <-
      substring(myseq, seq(1, nchar(myseq), 1), seq(1, nchar(myseq), 1))
    seqDB[, i] <- myseqarr
  }
  seqDB$CS <- CSarr
  
  write.csv(seqDB, file = "seqDB.csv")
  seqDB
}