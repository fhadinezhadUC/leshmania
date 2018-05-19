makeGraph <- function() {
  left <-
    read.table(
      "/home/fatemeh/leshmania/Samplemay10/script/leftflank_Leishmania_donovani_BPK282A1.txt"
    )
  right <-
    read.table(
      "/home/fatemeh/leshmania/Samplemay10/script/rightflank_Leishmania_donovani_BPK282A1.txt"
    )
  InfantumFlankMappedOnDonovani_BP <- data.frame(left, right$V2)
  names(InfantumFlankMappedOnDonovani_BP) <-
    c("seqname", "leftflank", "rightflank")
  left <-
    read.table(
      "/home/fatemeh/leshmania/Samplemay10/script/leftflank_Leishmania_donovani_strain_BHU_1220.txt"
    )
  right <-
    read.table(
      "/home/fatemeh/leshmania/Samplemay10/script/rightflank_Leishmania_donovani_strain_BHU_1220.txt"
    )
  InfantumFlankMappedOnDonovani_strain <- data.frame(left, right$V2)
  names(InfantumFlankMappedOnDonovani_strain) <-
    c("seqname", "leftflank", "rightflank")
  
  InfantumFlanks <-
    read.table("/home/fatemeh/leshmania/Samplemay10/script/infantumflankingpositions.txt")
  infantum_genecoordinate <-
    read.table("/home/fatemeh/leshmania/Samplemay10/script/infantumcomponents.txt")
  donovani_BP_genecoordinate <-
    read.table("/home/fatemeh/leshmania/Samplemay10/script/donovani_BP2components.txt")
  donovani_strain_genecoordinate <-
    read.table("/home/fatemeh/leshmania/Samplemay10/script/donovani_straincomponents.txt")
  #for (i in 1:length(InfantumFlankMappedOnDonovani_BP$sename)) {
  #  if(InfantumFlankMappedOnDonovani_BP$sename=="*")
  #  {Infa}
  #}
  
  #  for (i in 1:length(infantum_genecoordinate$seqname)) {
  #    for (j in 1:length(donovani_BP_genecoordinate$seqname)) {
  #      if (infantum_genecoordinate$sequence[i] == donovani_BP_genecoordinate$sequence[j])
  #      {
  #        l <-
  #          as.integer(InfantumFlankMappedOnDonovani_BP$leftflank[infantum_genecoordinate$newset])
  #        r <-
  #          as.integer(InfantumFlankMappedOnDonovani_BP$rightflank[infantum_genecoordinate$newset])
  #        name <- InfantumFlankMappedOnDonovani_BP$seqname
  #        if ((donovani_BP_genecoordinate$position < r) &&
  #            (donovani_BP_genecoordinate$position > l) &&
  #            (donovani_BP_genecoordinate$seqname == name))
  #        {
  #          #make a node between these two genes
  #        }
  #      }
  #    }
  #  }
  
  #  for (i in 1:length(infantum_genecoordinate$seqname)) {
  #    for (j in 1:length(donovani_strain_genecoordinate$seqname)) {
  #      if(infantum_genecoordinate$sequence[i]==donovani_strain_genecoordinate$sequence[j])
  #      {
  #        l<-as.integer(InfantumFlankMappedOnDonovani_BP$leftflank[infantum_genecoordinate$newset])
  #        r<-as.integer(InfantumFlankMappedOnDonovani_BP$rightflank[infantum_genecoordinate$newset])
  #        name<-InfantumFlankMappedOnDonovani_BP$sename
  #        if( (donovani_strain_genecoordinate$position < r) && (donovani_strain_genecoordinate$position > l) && (donovani_strain_genecoordinate$seqname==name))
  #        {
  #          #make a node between these two genes
  #        }
  #      }
  #    }
  # }
  # we can say that all the read in a tight anchor are orthologous
  for (i in 1:length(InfantumFlanks$setnumber)) {
    filename <- paste(i, ".txt", sep = "")
    sink(file = filename)
    print("infantum")
    #writeLines("infantum", file = filename, sep = "\n")
    for (j in 1:length(infantum_genecoordinate$newset)) {
      if (i == infantum_genecoordinate$newset[j]) {
        # write them in a file called ortholog candidates
        print(infantum_genecoordinate[j,])
       # sink()
        #print
      }
    }
    #
    print("donovani_strain")
    for (t in 1:length(donovani_strain_genecoordinate$position)) {
      #print(t)
      l <- as.integer(InfantumFlankMappedOnDonovani_strain$leftflank[i])
      r <- as.integer(InfantumFlankMappedOnDonovani_strain$rightflank[i])
      name <- InfantumFlankMappedOnDonovani_strain$seqname[i]
      if ((as.integer(donovani_strain_genecoordinate$position[t]) > l) &&
          (as.integer(donovani_strain_genecoordinate$position[t]) < r) &&
          (as.character(donovani_strain_genecoordinate$seqname[t])==as.character(name)))
      {
        # write them in a fie called ortholog candidates
        # write.table(donovani_strain_genecoordinate[t,],
        #            file = filename,
        #            append = TRUE)
        print(donovani_strain_genecoordinate[t,])
        
      }
    }
    print("donovani_BP")
    for (t in 1:length(donovani_BP_genecoordinate$position)) {
      l <- as.integer(InfantumFlankMappedOnDonovani_BP$leftflank[i])
      r <- as.integer(InfantumFlankMappedOnDonovani_BP$rightflank[i])
      name <- InfantumFlankMappedOnDonovani_BP$seqname[i]
      if ((as.integer(donovani_BP_genecoordinate$position[t]) > l) &&
          (as.integer(donovani_BP_genecoordinate$position[t]) < r) &&
          (as.character(donovani_BP_genecoordinate$seqname[t])==as.character(name)))
      {
        # write them in a fie called ortholog candidates
        print(donovani_BP_genecoordinate[t,])
        
        
      }
    }
    
    #print(t)
    sink()
  }
}
