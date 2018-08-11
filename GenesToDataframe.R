geneToDataframe <- function() {
  library(stringr)
  library(gridExtra)
  
  filepath <-
    "/home/fatemeh/leshmania/TryTrypDB_Aug2017_alltRNAs.tfam.fas"
  con = file(filepath, "r")
  sourceOrg = ""
  genename = ""
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
  geneseq=""
  tseintronbegin=""
  tseintronend=""
  geneinfo <-
    data.frame(
      sourceOrg="",
      genename = "",
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
      tsecovescore = "",
      geneseq="",
      tseintronbegin="",
      tseintronend=""
    )
  flag = 0
  #Adding the sourceorganism to those genes that don't have it which are :
  while (TRUE) {
    flag = flag + 1
    line = readLines(con, n = 1)
    # print(line)
    if (length(line) == 0) {
      break
    }
    
    if (flag %% 2 == 1)
    {
      linearr <- unlist(strsplit(line, split = " "))
      #print(linearr[1])
      #for (i in 1:length(linearr)) {
      # temp <- grep("araseq=*", linearr, value = TRUE)
      # if (length(temp) == 0)
      #   temp <- NA
      # geneseq <- substring(temp, 8)
      temp <- grep("tseintronbegin=*", linearr, value = TRUE)
      if (length(temp) == 0)
        temp <- NA
      tseintronbegin <- substring(temp, 16)
      temp <- grep("tseintronend=*", linearr, value = TRUE)
      if (length(temp) == 0)
        temp <- NA
      tseintronend <- substring(temp, 14)
      
      temp <- grep("sourceorganism=*", linearr, value = TRUE)
      if (length(temp) == 0)
        temp <- NA
      sourceOrg <- substring(temp, 16)
      temp <- linearr[1]
      genename <- substring(temp, 2)
      temp <- grep("araidentity*", linearr, value = TRUE)
      if (length(temp) == 0)
        temp <- NA
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
      
      #  break
      #}
      # if(linearr[1]==">Leishmania_braziliensis_GCF_000002845.2_ASM284v2_genomic_77")
      #   print(araidentity)
    }
    if(flag %% 2 == 0)
    {
      geneseq <- line
      tempdf <-
        data.frame(
          sourceOrg,
          genename,
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
          tsecovescore,
          geneseq,
          tseintronbegin,
          tseintronend
        )
      geneinfo <- rbind(tempdf, geneinfo)
    }
  }
  close(con)
  
  isNa <- is.na(geneinfo$sourceOrg)
  noSourceOrgfields <- geneinfo[isNa,]
  write.table(
    noSourceOrgfields ,
    "/home/fatemeh/leshmania/mainfolder/noSourceOrg.txt",
    col.names = FALSE
  )
  geneinfo$genename <- as.character(geneinfo$genename)
  geneinfo$sourceOrg <- as.character(geneinfo$sourceOrg)

  for (i in 1:nrow(geneinfo)) {
    if (is.na(geneinfo$sourceOrg[i])) {
      # print(i)
      # print(geneinfo$genename[i])
      # in general those that do not have sourceorganism are in uppercase!!!
      if (length(grep("Trypanosoma_cruzi_strain_CL_Brener*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        #Trypanosoma_cruzi_strain_CL_Brener
        geneinfo$sourceOrg[i] = "Trypanosoma_cruzi_strain_CL_Brener"
      else if (length(grep("TriTrypDB-33_TvivaxY486_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
      geneinfo$sourceOrg[i] = "Trypanosoma_vivax_Y486"
      else if (length(grep("TriTrypDB-33_TgrayiANR4_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        #Trypanosoma_grayi_ANR4 TriTrypDB-33_TgrayiANR4_Genome_43 and 67 do not have source organism and their reported sequence is in uppercase as opposed to others which are lowercase
        geneinfo$sourceOrg[i] = "Trypanosoma_grayi_ANR4"
      else if (length(grep("TriTrypDB-33_TcruziSylvioX10-1_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Trypanosoma_cruzi_Sylvio_X10/1"
      else if (length(grep("TriTrypDB-33_TcruziDm28c_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Trypanosoma_cruzi_Dm28c"
      else if (length(grep(
        "TriTrypDB-33_TcruziCLBrenerNon-Esmeraldo-like_Genome*",
        geneinfo$genename[i],
        value = FALSE
      ))!=0)
        geneinfo$sourceOrg[i] = "Trypanosoma_cruzi_CL_Brener_Non-Esmeraldo-like"
      else if (length(grep("TriTrypDB-33_TcongolenseIL3000_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Trypanosoma_congolense_IL3000"
      else if (length(grep("TriTrypDB-33_TbruceiTREU927_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Trypanosoma_brucei_brucei_TREU927"
      else if (length(grep("TriTrypDB-33_LtarentolaeParrotTarII_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Leishmania_tarentolae_Parrot-TarII"
      else if (length(grep("TriTrypDB-33_LspMARLEM2494_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Leishmania_sp._MAR_LEM2494"
      else if (length(grep("TriTrypDB-33_LseymouriATCC30220_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Leptomonas_seymouri_ATCC_30220"
      else if (length(grep("TriTrypDB-33_LpyrrhocorisH10_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Leptomonas_pyrrhocoris_H10"
      else if (length(grep("TriTrypDB-33_LpanamensisMHOMCOL81L13_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Leishmania_panamensis_MHOM/COL/81/L13"
      else if (length(grep("TriTrypDB-33_LdonovaniBPK282A1_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Leishmania_donovani_BPK282A1"
      else if (length(grep("TriTrypDB-33_LdonovaniBHU1220_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Leishmania_donovani_strain_BHU_1220"
      else if (length(grep(
        "TriTrypDB-33_LbraziliensisMHOMBR75M2904_Genome*",
        geneinfo$genename[i],
        value = FALSE
      ))!=0)
        geneinfo$sourceOrg[i] = "Leishmania_braziliensis_MHOM/BR/75/M2904"
      else if (length(grep("TriTrypDB-33_EmonterogeiiLV88_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Endotrypanum_monterogeii_strain_LV88"
      else if (length(grep("TriTrypDB-33_CfasciculataCfCl_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Crithidia_fasciculata_strain_Cf-Cl"
      else if (length(grep("TriTrypDB-33_BayalaiB08-376_Genome*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Blechomonas_ayalai_B08-376" # how can a sequence which has too many N known as gene?!
      else if (length(grep("SequencesByTaxon_Tcruzi_tula*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] = "Trypanosoma_cruzi_Tula_cl2"
      else if (length(grep("SequencesByTaxon_Tcruzi_Jr*",
               geneinfo$genename[i],
               value = FALSE))!=0)
        geneinfo$sourceOrg[i] =
          "Trypanosoma_cruzi_JR_cl._4"
      else if (length(grep(
        "SequencesByTaxon_Leishmania_enriettii_LEM3045*",
        geneinfo$genename[i],
        value = FALSE
      ))!=0)
        geneinfo$sourceOrg[i] =
          "Leishmania_enriettii_strain_LEM3045"
      #if(grep("Leishmania_braziliensis_GCF_000002845.2_ASM284v2_genomic*", geneinfo$genename[i], value = FALSE))
      # geneinfo$sourceOrg[i]="Leishmania_braziliensis_MHOM_BR_75_M2904"
      
    }
  }
  # I will remove "Leishmania_braziliensis_GCF_000002845.2_ASM284v2_genomic" genes since we have no reference sequence for them in our DB
  isNa <- is.na(geneinfo$sourceOrg)
  geneinfo <- geneinfo[!isNa,]
  write.table(geneinfo,
              "/home/fatemeh/leshmania/mainfolder/geneinfoDF.txt",
              col.names = FALSE)
  # we prefer ara information since the sequence is for them and if it was NA then tse!
  genesummery <-
    data.frame(
      sourceOrg = geneinfo$sourceOrg,
      genename = geneinfo$genename,
      identity = geneinfo$araidentity,
      direction = geneinfo$aradirection,
      begin = geneinfo$arabegin,
      end = geneinfo$araend,
      ac = geneinfo$araac,
      sourceSO = geneinfo$sourceSO,
      sourceseq = geneinfo$sourceseq,
      arascore = geneinfo$arascore,
      tsecovescore = geneinfo$tsecovescore,
      geneseq = geneinfo$geneseq,
      tseintronbegin = geneinfo$tseintronbegin,
      tseintronend = geneinfo$tseintronend
    )
  genesummery$sourceOrg <- as.character(genesummery$sourceOrg)
  genesummery$identity <- as.character(genesummery$identity)
  genesummery$direction <- as.character(genesummery$direction)
  genesummery$begin <- as.character(genesummery$begin)
  genesummery$end <- as.character(genesummery$end)
  genesummery$ac <- as.character(genesummery$ac)
  genesummery$geneseq <- as.character(genesummery$geneseq)
  
  # if the identity which was already picked from tse was NA then put the ara value instead
  for (i in 1:(nrow(genesummery) - 1)) {
    if (is.na(genesummery$identity[i]))
    {
      genesummery$identity[i] = as.character(geneinfo$tseidentity[i])
      genesummery$direction[i] = as.character(geneinfo$tsedirection[i])
      genesummery$begin[i] = as.character(geneinfo$tsebegin[i])
      genesummery$end[i] = as.character(geneinfo$tseend[i])
      genesummery$ac[i] = as.character(geneinfo$tseac[i])
      
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
  
  genesummery$geneticcode <- 0
  for (i in 1:nrow(genesummery)) {
    genesummery$geneticcode[i] <-
      paste(genesummery$aminoacid[i], genesummery$ac[i], sep = "")
  }
  # deleting the last row which is empty. it is the first row we made to initialize the dynamic data frame
  genesummery <- genesummery[-c(nrow(genesummery)),]
  library(ggplot2)
  library(ggrepel)
  genesummery$begin <- as.integer(genesummery$begin)
  genesummery$end <- as.integer(genesummery$end)
  # genesummery$tseintronbegin = as.integer(geneinfo$tseintronbegin)
  # genesummery$tseintronend = as.integer(geneinfo$tseintronend)
  bad <- is.na(genesummery$tseintronbegin)
  genesummery$tseintronbegin[bad]=0
  genesummery$tseintronend[bad]=0
  write.table(genesummery,
              "/home/fatemeh/leshmania/mainfolder/geneinfoDF.txt",
              col.names = FALSE,quote = FALSE)
  #genesummery
  
}

#