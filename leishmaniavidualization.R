clustercount <- function(d, org) {
  # Read the the gene files with its coordiante on a genome.
  # If the distance between two genes from is less than d, consider them as clusters.
  # sample of genomename parametes:
  #infantum
  #donovani_strain
  #donovani_BP2
  genomename <- paste("aligned_", org, "_coordinate.txt", sep = "")
  filepath <-
    paste("/home/fatemeh/leshmania/Samplemay10/script/",
          genomename,
          sep = "")
  genecoordinate <- read.table(filepath)
  genecoordinate$flag <- 0
  names(genecoordinate) <-
    c("seqname", "position", "sequence", "newset")
  genecoordinate$newset[1] <- 1
  setnumber <- 1
  for (i in 1:(length(genecoordinate$position) - 1)) {
    distance <-
      genecoordinate$position[i + 1] - genecoordinate$position[i]
    if ((distance < d) &&
        (genecoordinate$seqname[i + 1] == genecoordinate$seqname[i]))
    {
      genecoordinate$newset[i + 1] <- setnumber
    }
    else
    {
      setnumber <- setnumber + 1
      genecoordinate$newset[i + 1] <- setnumber
    }
  }
  plot(
    table(genecoordinate$newset),
    xlab = "Cluster",
    ylab = "Number of genes within the cluster",
    col = "red",
    main = "Number of genes in each cluster"
  )
  genecoordinate$newset[length(genecoordinate$newset)]
}

clustercountprofile <-
  function(org1 = "infantum",
           org2 = "donovani_strain",
           org3 = "donovani_BP2",
           d) {
    dlist <- seq(100, 50000, by = 1000)
    numberofclusters <-
      lapply(dlist, org1, FUN =  clustercount)
    
    library(ggplot2)
    mydata <- cbind(dlist, numberofclusters)
    mydata <- data.frame(mydata)
    mydata$dlist <- as.integer(mydata$dlist)
    mydata$numberofclusters <- as.integer(mydata$numberofclusters)
    g <-
      ggplot(mydata,
             aes(
               x = mydata$dlist,
               y = mydata$numberofclusters,
               colour = org1
             )) + geom_line() + labs(colour = "organisms") + labs(x = "Maximum Distance Between Genes in a cluster", y =
                                                                    "Number of Cluster in the Genome", title = "Number of clusters in an organism VS. Maximum distance allowed between genes considered as a cluster ")
    
    numberofclusters <-
      lapply(dlist, org2, FUN =  clustercount)
    mydata2 <- cbind(dlist, numberofclusters)
    mydata2 <- data.frame(mydata2)
    mydata2$dlist <- as.integer(mydata2$dlist)
    mydata2$numberofclusters <- as.integer(mydata2$numberofclusters)
    g <-
      g + geom_line(data = mydata2,
                    aes(
                      x = mydata2$dlist,
                      y = mydata2$numberofclusters,
                      color = org2
                    ))
    
    numberofclusters <-
      lapply(dlist, org3, FUN =  clustercount)
    mydata3 <- cbind(dlist, numberofclusters)
    mydata3 <- data.frame(mydata3)
    mydata3$dlist <- as.integer(mydata3$dlist)
    mydata3$numberofclusters <- as.integer(mydata3$numberofclusters)
    g <-
      g + geom_line(data = mydata3,
                    aes(
                      x = mydata3$dlist,
                      y = mydata3$numberofclusters,
                      color = org3
                    ))
    g
    
    MyList<- list("a"=mydata, "b"=mydata2, "c"=mydata3) 
    return(MyList) 
  }

# Calculates number of genes in each genome close to the end of the sequence(closer than distance d)
# We length of each sequence from the reference genome file
# read the reference files make an data frame of name of sequence and their length
# awk '{if(match($1,">+")){print $0}}' Leishmania_donovani_strain_BHU_1220.fasta > Headers_Leishmania_donovani_strain_BHU_1220
# awk '{for(i=1; i < NF; i++){if(match($i, "to")){print $1,$(i+1)}}}' Headers_Leishmania_infantum_JPCM5.txt > infantum_seqlength.txt

marginclusters <- function(d, org) {
  # we just need to revise the file infantumflankingpositions.txt by adding the length of the sequence to each row
  
  path1 <-
    paste("/home/fatemeh/leshmania/Samplemay10/reference/",
          org,
          "_seqlength.txt",
          sep = "")
  Seqlength <-
    read.table(path1)
  Seqlength$V1 <- gsub(">", "", Seqlength$V1)
  Seqlength$V2 <- as.integer(Seqlength$V2)
  
  path2 <-
    paste(
      "/home/fatemeh/leshmania/Samplemay10/script/",
      org,
      "flankingpositions.txt",
      sep = ""
    )
  clustermargins <-
    read.table(path2)
  
  clustermargins <-
    data.frame(clustermargins$V3,
               clustermargins$V4,
               clustermargins$V5,
               clustermargins$V1)
  names(clustermargins) <-
    c("seqname", "first", "last", "seqlength")
  clustermargins$seqlength <- 0
  for (i in 1:nrow(clustermargins)) {
    for (j in 1:nrow(Seqlength)) {
      if (clustermargins$seqname[i] == Seqlength$V1[j])
        clustermargins$seqlength[i] <- Seqlength$V2[j]
    }
    
  }
  count = 0
  for (i in 1:nrow(clustermargins)) {
    if (clustermargins$first[i] < d ||
        (clustermargins$seqlength[i] - clustermargins$last[i]) < d)
      count = count + 1
  }
  print(count)
}

mymain <- function() {
 # clustercount(d, organism1)
#  clustercount(d, organism2)
#  clustercount(d, organism3)
#  clustercountprofile(organism1, organism2, organism3, d)
  print(clustercountprofile("infantum","donovani_strain", "donovani_BP2",
                            10000)[[1]])
  g <-
    ggplot(clustercountprofile("infantum","donovani_strain", "donovani_BP2",
                               10000)[[1]],
           aes(
             x = clustercountprofile("infantum","donovani_strain", "donovani_BP2",
                                     10000)[[1]]$dlist,
             y = clustercountprofile("infantum","donovani_strain", "donovani_BP2",
                                     10000)[[1]]$numberofclusters,
             colour = org1
           )) + geom_line() + labs(colour = "organisms") + labs(x = "Maximum Distance Between Genes in a cluster", y =
                                                                  "Number of Cluster in the Genome", title = "Number of clusters in an organism VS. Maximum distance allowed between genes considered as a cluster ")
g
  #  marginclusters(d,organism1)
}
