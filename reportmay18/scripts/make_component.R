makecomponent <- function(){
  genecoordinate <- read.table("/home/fatemeh/leshmania/Samplemay10/script/aligned_infantum_coordinate.txt")
  genecoordinate$flag <- 0
  names(genecoordinate) <- c("seqname","position","sequence","newset")
  genecoordinate$newset[1] <- 1
  setnumber <- 1
  #distance <- genecoordinate$position[2] - genecoordinate$position[1]
    for (i in 1:(length(genecoordinate$position)-1)) {
      distance <- genecoordinate$position[i+1] - genecoordinate$position[i]
      if((distance < 10000) && (genecoordinate$seqname[i+1]==genecoordinate$seqname[i])) # make sur it works!
      {
          genecoordinate$newset[i+1] <- setnumber
      }
      else
      {
        setnumber <- setnumber+1
        genecoordinate$newset[i+1] <- setnumber
      }
    }
  genecoordinate <- genecoordinate[order(genecoordinate$seqname,genecoordinate$position),]
  write.table(genecoordinate,"/home/fatemeh/leshmania/Samplemay10/script/infantumcomponents.txt")
  # extract the left and right flanking region for this genome for each component
  m <- matrix(nrow = setnumber,ncol = 4,data = 0) 
  flankregionsDF <- as.data.frame(m)
  names(flankregionsDF)<- c("setnumber","seqname","leftposition","rightposition")

  flankregionsDF$setnumber <- seq(1,setnumber,1)
  flankregionsDF$leftposition[1] <- genecoordinate$position[1]
  flankregionsDF$seqname <- as.character(flankregionsDF$seqname)
  genecoordinate$seqname <- as.character(genecoordinate$seqname)
  flankregionsDF$seqname[1] <- genecoordinate$seqname[1]
  for (i in 1:(length(genecoordinate$position)-1)) {
    firstset <- genecoordinate$newset[i]
    secondset <- genecoordinate$newset[i+1]
    if(firstset != secondset)
    {
      flankregionsDF$seqname[secondset] <- genecoordinate$seqname[i+1] 
      flankregionsDF$rightposition[firstset] <- genecoordinate$position[i]
      flankregionsDF$leftposition[secondset] <- genecoordinate$position[i+1]
    }
  }
  flankregionsDF$rightposition[secondset] <- genecoordinate$position[length(genecoordinate$position)]
  flankregionsDF$seqname[secondset] <- genecoordinate$seqname[length(genecoordinate$position)] 
  write.table(flankregionsDF,"/home/fatemeh/leshmania/Samplemay10/script/infantumflankingpositions.txt")
}