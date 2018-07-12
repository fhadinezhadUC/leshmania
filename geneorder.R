genesorder <- function() {
  # read all the genes from gene file "TryTrypDB_Aug2017_alltRNAs.tfam.fas" and extract the genes that are for the Organisms we are interested in
  # example of input organism names:
  # Leishmania_infantum_JPCM5
  # Leishmania_donovani_strain_BHU_1220
  # The goal is to sort genes for each sequence
  library(stringr)
  library(gridExtra)
  # files <- list.files() this will give a list of the files in the current directory
  # Trypanosoma_brucei_gambiense_DAL972
  # Trypanosoma_evansi_strain_STIB_805
  organismname <- "Trypanosoma_evansi_strain_STIB_805" #"Trypanosoma_brucei_gambiense_DAL972" #"Leishmania_infantum_JPCM5"
  filepath <-
    "/home/fatemeh/leshmania/TryTrypDB_Aug2017_alltRNAs.tfam.fas"
  con = file(filepath, "r")
  araidentity = ""
  tseidentity = ""
  aradirection = ""
  tsedirection = ""
  arabegin = ""
  tsebegin = ""
  araend = ""
  tseend = ""
  tseac = ""
  araac = ""
  sourceSO = ""
  sourceseq = ""
  arascore = ""
  tsecovescore = ""
  geneinfo <-
    data.frame(
      araidentity = "",
      tseidentity = "",
      aradirection = "",
      tsedirection = "",
      arabegin = "",
      tsebegin = "",
      araend = "",
      tseend = "",
      tseac = "",
      araac = "",
      sourceSO = "",
      sourceseq = "",
      arascore = "",
      tsecovescore = ""
    )
  flag = 0
  while (TRUE) {
    line = readLines(con, n = 1)
    if (length(line) == 0) {
      break
    }
    
    linearr <- unlist(strsplit(line, split = " "))
    #print(linearr)
    for (i in 1:length(linearr)) {
      org <- paste("sourceorganism=", organismname, sep = "")
      if (linearr[i] == org)
      {
        temp <- grep("araidentity*", linearr, value = TRUE)
        araidentity <- substring(temp, 13)
        temp <- grep("tseidentity*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        tseidentity <- substring(temp, 13)
        temp <- grep("aradirection*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        aradirection <- substring(temp, 14)
        temp <- grep("tsedirection*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        tsedirection <- substring(temp, 14)
        temp <- grep("arabegin*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        arabegin <- substring(temp, 10)
        temp <- grep("tsebegin*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        tsebegin <- substring(temp, 10)
        temp <- grep("araend*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        araend <- substring(temp, 8)
        temp <- grep("tseend*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        tseend <- substring(temp, 8)
        temp <- grep("tseac*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        tseac <- substring(temp, 7)
        temp <- grep("araac*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        araac <- substring(temp, 7)
        temp <- grep("sourceSO*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        sourceSO <- substring(temp, 10)
        temp <- grep("sourceseq*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        sourceseq <- substring(temp, 11)
        temp <- grep("arascore*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        arascore <- substring(temp, 10)
        temp <- grep("tsecovescore*", linearr, value = TRUE)
        if (length(temp) == 0)
          temp <- NA
        tsecovescore <- substring(temp, 14)
        
        tempdf <-
          data.frame(
            araidentity,
            tseidentity,
            aradirection,
            tsedirection,
            arabegin,
            tsebegin,
            araend,
            tseend,
            tseac,
            araac,
            sourceSO,
            sourceseq,
            arascore,
            tsecovescore
          )
        # print(tempdf)
        flag = 1
        break
      }
    }
    
    if (flag == 1)
    {
      geneinfo <- rbind(tempdf, geneinfo)
      flag = 0
    }
    # sourceSO=contig/chromosom/supercontig
    # sourceseq=LinJ.03
    
    # arascore
    # tsecovescore
    # score needed to find the psudogenes.
    #
  }
  close(con)
 
  
 
  # for now we just take the tse output into account if it was NA then aragorn
  genesummery <-
    data.frame(
      identity = geneinfo$tseidentity,
      direction = geneinfo$tsedirection,
      begin = geneinfo$tsebegin,
      end = geneinfo$tseend,
      ac = geneinfo$tseac,
      sourceSO = geneinfo$sourceSO,
      sourceseq = geneinfo$sourceseq,
      arascore = geneinfo$arascore,
      tsecovescore = geneinfo$tsecovescore
    )
  genesummery$identity <- as.character(genesummery$identity)
  genesummery$direction <- as.character(genesummery$direction)
  genesummery$begin <- as.character(genesummery$begin)
  genesummery$end <- as.character(genesummery$end)
  genesummery$ac <- as.character(genesummery$ac)
  
  for (i in 1:(nrow(genesummery) - 1)) {
    if (is.na(genesummery$identity[i]))
    {
      genesummery$identity[i] = as.character(geneinfo$araidentity[i])
      genesummery$direction[i] = as.character(geneinfo$aradirection[i])
      genesummery$begin[i] = as.character(geneinfo$arabegin[i])
      genesummery$end[i] = as.character(geneinfo$araend[i])
      genesummery$ac[i] = as.character(geneinfo$araac[i])
      
    }
  }
  
  
  genesummery$aminoacid <- 0
  genesummery$aminoacid <- as.character(genesummery$aminoacid)
  for (i in 1:nrow(genesummery)) {
    id <- tolower(genesummery$identity[i])
    
    if (id == "ala")
      genesummery$aminoacid[i] <- "A"
    if (id == "arg")
      genesummery$aminoacid[i] <- "R"
    if (id == "asn")
      genesummery$aminoacid[i] <- "N"
    if (id == "asp")
      genesummery$aminoacid[i] <- "D"
    if (id == "cys")
      genesummery$aminoacid[i] <- "C"
    if (id == "gln")
      genesummery$aminoacid[i] <- "Q"
    if (id == "glu")
      genesummery$aminoacid[i] <- "E"
    if (id == "gly")
      genesummery$aminoacid[i] <- "G"
    if (id == "his")
      genesummery$aminoacid[i] <- "H"
    if (id == "ile")
      genesummery$aminoacid[i] <- "l"
    if (id == "start")
      genesummery$aminoacid[i] <- "start"
    if (id == "leu")
      genesummery$aminoacid[i] <- "L"
    if (id == "lys")
      genesummery$aminoacid[i] <- "K"
    if (id == "met")
      genesummery$aminoacid[i] <- "M"
    if (id == "phe")
      genesummery$aminoacid[i] <- "F"
    if (id == "pro")
      genesummery$aminoacid[i] <- "P"
    if (id == "ser")
      genesummery$aminoacid[i] <- "S"
    if (id == "thr")
      genesummery$aminoacid[i] <- "T"
    if (id == "trp")
      genesummery$aminoacid[i] <- "W"
    if (id == "tyr")
      genesummery$aminoacid[i] <-
        "Y"
    if (id == "val")
      genesummery$aminoacid[i] <-
        "V"
    if (id == "sec")
      genesummery$aminoacid[i] <-
        "U"
    if (id == "stop")
      genesummery$aminoacid[i] <-
        "stop"
    
  }
  #print(geneinfo)
  genesummery <-
    genesummery[order(genesummery$sourceseq, genesummery$begin),]
  genesummery$geneticcode < -0
  for (i in 1:nrow(genesummery)) {
    genesummery$geneticcode[i] <-
      paste(genesummery$aminoacid[i], genesummery$ac[i], sep = "")
  }
  # deletng the last row whici is empty. it is the first row we made to initialize the dynamic data frame
  genesummery <- genesummery[-c(nrow(genesummery)),]
  library(ggplot2)
  library(ggrepel)
  genesummery$begin <- as.integer(genesummery$begin)
  genesummery$end <- as.integer(genesummery$end)

  
  # determining the clusters first and then represent each cluster in one plot
  genesummery <- genesummery[order(genesummery$sourceseq,genesummery$begin),]
  genesummery$cluster <- 0
  genesummery$cluster[1] <- 1
  setnumber <- 1
  #distance <- genecoordinate$position[2] - genecoordinate$position[1]
  for (i in 1:(length(genesummery$begin)-1)) {
    distance <- genesummery$begin[i+1] - genesummery$begin[i]
    if((distance < 10000) && (genesummery$sourceseq[i+1]==genesummery$sourceseq[i])) # make sur it works!
    {
      genesummery$cluster[i+1] <- setnumber
    }
    else
    {
      setnumber <- setnumber+1
      genesummery$cluster[i+1] <- setnumber
    }
  }

  # ggplot( data = mydata,
  #         aes(
  #           x = mydata$begin,
  #           y = mydata$sourceseq,
  #           label = mydata$geneticcode,
  #           color = mydata$direction
  #         )
  # ) + geom_point()  + geom_label_repel(
  #   aes(label = mydata$geneticcode),
  #   box.padding   = 0.35,
  #   point.padding = 0.5,
  #   segment.color = 'grey50'
  # ) + theme(legend.position="none",
  #           axis.title.x = element_blank(),
  #           axis.title.y = element_blank(),
  #           plot.margin=unit(c(1,1,0,1), "cm"),
  #           panel.spacing =unit(c(1,1,0,1), "cm"))

  
  
  #ggsave("geneorders.jpg", width = 20, height = 20)
  #genesummery <- genesummery[genesummery$sourceseq=="LinJ.36",]
  listofplots <- lapply(1:genesummery$cluster[length(genesummery$cluster)], function(i){
    mydata = genesummery[genesummery$cluster==i,]
    ggplot( data = mydata,
    aes(
      x = mydata$begin,
      y = mydata$sourceseq,
      label = mydata$geneticcode,
      color = mydata$direction
    )
  ) + geom_point()+ theme(legend.position="none",
            
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            plot.margin=unit(c(1,1,0,1), "cm"),
            panel.spacing =unit(c(1,1,0,1), "cm"))+ theme(axis.text.x=element_text(angle=90, hjust=1))
    })
  #+ theme_bw() + xlab("position") + ylab("reference sequence")})
  #ggsave("geneorders.jpg", width = 20, height = 20)
  do.call(grid.arrange, listofplots)
 # grid.arrange(listofplots[[1]],listofplots[[2]],listofplots[[3]],listofplots[[4]],listofplots[[5]],listofplots[[6]],listofplots[[7]],listofplots[[8]],listofplots[[9]],listofplots[[10]],listofplots[[11]],
 #              listofplots[[12]],listofplots[[13]],listofplots[[14]],listofplots[[15]],listofplots[[16]],listofplots[[17]],listofplots[[18]],listofplots[[19]],listofplots[[20]],listofplots[[21]],ncol=4)
 
 genesummery

}

#