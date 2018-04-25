# R script tp visualize the gene data
leishmania <- function(filepath){
    myfile = file("/home/fatemeh/leshmania/sample2Test_Apr20/output.txt", "r")
    temp<-character(length = 3)
    while ( TRUE ) {
      line = readLines(myfile, n = 1)
      if ( length(line) == 0 ) {
        break
      }
      if (grepl("^[A-Za-z]+$", substr(line,1,2), perl = T))
      {
        components=unlist(strsplit(line,"[|]"))
        temp<-rbind(temp,components)
      }
    }
    df <- as.data.frame(temp)
    df$V3 <- substr(df$V3,1,1)
    df$V3<- as.integer(df$V3)
    close(myfile)
    # Diagramp with genes Vs. # of hits and organism (same organism same colour )
    ggplot(data = df, mapping = aes(x=V3)) + geom_bar(aes(fill=V1)) + xlab("Number of Hits") +
      ylab("Genes") #+ theme(legend.position="none")
    # makes a new dataframe to see how many geneOrganism repeats we have 
    geneOrg <- paste(df$V1,df$V2,sep = "")
    df2 <- data.frame(geneOrg,df$V1,df$V2)
    names(df2) <- c("GeneOrg","Org","Gene")
    ggplot(data = df2 , mapping = aes(x = geneOrg))+geom_bar(aes(fill=Gene))
    # Diagram to see the frequency of identical genes (same Organism, same color)
    ggplot(data = df2 , mapping = aes(x = Gene))+geom_bar(aes(fill=Org))
    
}
