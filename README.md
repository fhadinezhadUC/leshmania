

In order to map the genes to their genome:
First, rename all the genome .fasta files to their sequence name from the first line of the .fasta file by running the [rename.sh script](https://github.com/fhadinezhadUC/leshmania/blob/master/editNames.sh).  

Second, in order to do some preprocessing on the TryTrypDB_Aug2017_alltRNAs.tfam.fas file to revome the even lines (which is the gene sequence and is repeated in araquery field) using the fallowing code:
awk '{if(NR%2==1){print $0}}' TryTrypDB_Aug2017_alltRNAs.tfam.fas > temp.txt
Then, remove ines that do not have the sourceorganism field. (we will deal with hese files later!) 
awk '{for(i=1; i < NF; i++){if(match($i,"sourceorganism*")){print $0; break;}}}' temp.txt > inputgenefile.txt

Third, read the TryTrypDB_Aug2017_alltRNAs.tfam.fas file line by line and take each gene and using blast align it to its source organism genome. Then, make an output.txt file like the bellow using [alignseq.sh script](https://github.com/fhadinezhadUC/leshmania/blob/master/alignseq.sh).


# Finds the source organism
# Makes a database with it
# Put the database in a folder with database name
# Finds the query gene sequence and put it in the query.txt file
# Run the blast command 
# Put the output of blast command in the file Hit
# Calculate number of hits of that gene on its source Organism and the position
# Edit the output.txt file by adding the information 
# Needs a preprocessing on the sequence file to remove the lines with even number, and extracts those genes that have Sourceorganism field
# run these two line on the gene file first:
# awk '{if(NR%2==1){print $0}}' TryTrypDB_Aug2017_alltRNAs.tfam.fas > temp.txt
# awk '{for(i=1; i < NF; i++){if(match($i,"sourceorganism*")){print $0; break;}}}' temp.txt > inputgenefile.txt
# we also ignored the sequences that has NNNNNN in them and they did not have the field araseq
# All the Reference .fasta Genome files are in the folder ReferenceGenomes in the currect directory along with the gene file

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/Genes.jpeg)



