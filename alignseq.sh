#!/bin/bash
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



while IFS='' read -r line || [[ -n "$line" ]]; do
sourceorganism=""
REFGENOME=""
QUERY=""
BLASTOUTPUT=""
DB=""
NUMHITS=""
#__________________________________________________________________

QUERY=$(echo "$line" | awk '{
		for(i=1; i < NF; i++)
		{
			if(match($i,"araseq*"))
			{
				query=substr($i,8)
			}
		}
		printf query 
}' )
sourceorganism=$(echo "$line" | awk '{
		for(i=1; i < NF; i++)
		{
			if(match($i,"sourceorganism*"))
			{
				sourceorganism = substr($i,16)	
			}
		}
		printf sourceorganism
}' )
#_____________________________________________________________________

REFGENOME=$(echo "$sourceorganism.fasta" | tr "/" "_")
REFGENOME=$(echo "ReferenceGenomes/$REFGENOME")
echo "$REFGENOME"
sudo makeblastdb -in "$REFGENOME" -out "$sourceorganism/$sourceorganism" -dbtype nucl -parse_seqids
echo "$QUERY" > query.fasta
blastn -query query.fasta -db "$sourceorganism/$sourceorganism" -outfmt 6 -out hits
NUMHITS=$(wc -l hits)
printf "$NUMHITS"
echo "$sourceorganism|$QUERY|$NUMHITS" >> output.txt

#____________________________________________________________________

while IFS='' read -r record || [[ -n "$record" ]]; do

startpos=$(echo "$record" | awk '{printf $9}')
endpos=$(echo "$record" | awk '{printf $10}')
echo "$startpos $endpos" >> output.txt

done < hits
#_____________________________________________________________________

done < "$1"
