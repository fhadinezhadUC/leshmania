CompareGeneEquality <- function() {
  filepath = "/home/fatemeh/leshmania/mainfolder/CCAtemplates/output.txt"
  con = file(filepath, "r")
  info <- data.frame(geneID="",geneseq="",foundseq="",direction="",next50bp="")
  geneID=""
  geneseq=""
  foundseq = ""
  foundseq1=""
  foundseq2=""
  direction=""
  next50bp=""
  
  flag = 0 
  while (TRUE) {
    if(flag == 0)
    {  
    line = readLines(con, n = 1)
    }
    flag=0
    if (length(line) == 0) {
      break
    }
    if(line == "+")
    {
      for (i in 1:9) {
        line = readLines(con, n = 1)
        if(line == "+")
        {   flag = 1
            break
        }
        if(i==1)
        {
          geneID = line
        }
        if(i==3)
        {
          geneseq = line
        }
        if(i==4)
        {
          direction = line
        }
        if(i==6)
        {
          foundseq1 = line
        }
        if(i==7)
        {
          foundseq2 = line
          foundseq=paste(foundseq1,foundseq2,sep="")
          
        }
        if(i==9)
        {
          next50bp = line
          temp <- data.frame(geneID,geneseq,foundseq,direction,next50bp)
          info <- rbind(temp,info)
        }
      }
    }
  }
  close(con)
  #
  # reverse complementing those rows with direction = reverse 
  info$geneseq <- as.character( tolower(info$geneseq))
  info$foundseq <- as.character( tolower(info$foundseq))
  info$direction <- as.character( info$direction)
  info$next50bp <- as.character( info$next50bp)
  info$geneID <- as.character( info$geneID)
  
  for (i in 1:nrow(info)) {
    if(info$direction[i] == "reverse")
    {
      myseq <- info$geneseq[i]
      myseqc <- chartr("ATGCNatgc","TACGNtacg",myseq)
      myseqrevc <- paste(rev(unlist(strsplit(myseqc,NULL))),collapse="") 
      info$geneseq[i] <- myseqrevc
    }
  }
  
  notequal <- info$foundseq != info$geneseq
  notequaldf <- info[notequal,]
  equal <- info$foundseq == info$geneseq
  equaldf <- info[equal,]
  # now that we checked the equality, we need to convert the reverse complemented genes.

  for (i in 1:nrow(equaldf)) {
    if(equaldf$direction[i] == "reverse")
    {
      myseq <- equaldf$geneseq[i]
      myseqc <- chartr("ATGCNatgc","TACGNtacg",myseq)
      myseqrevc <- paste(rev(unlist(strsplit(myseqc,NULL))),collapse="") 
      equaldf$geneseq[i] <- myseqrevc
    }
  }
  
  for (i in 1:nrow(notequaldf)) {
    if(notequaldf$direction[i] == "reverse")
    {
      myseq <- notequaldf$geneseq[i]
      myseqc <- chartr("ATGCNatgc","TACGNtacg",myseq)
      myseqrevc <- paste(rev(unlist(strsplit(myseqc,NULL))),collapse="") 
      notequaldf$geneseq[i] <- myseqrevc
    }
  }
  write.table(equaldf,file = "/home/fatemeh/leshmania/mainfolder/CCAtemplates/equaldf.txt",sep = " ")
  write.table(notequaldf,file = "/home/fatemeh/leshmania/mainfolder/CCAtemplates/notequalDF.txt",sep = " ")
  
  
}