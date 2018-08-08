#!/bin/bash
# index all the files 
yourfilenames=$(ls *.fasta)
for FILE in $yourfilenames; do
	samtools faidx "${FILE}"
done
 
# Using awk, read the sequences from the file geneinfoDF.txt and for each sequence find the sequence on genome.
# 
# read genename($3) sourceOrg($2) sourceseq($10) begin($6) end($7) 
awk '{ 
	samtools faidx $2 $10:$6-$7
}' geneinfoDF.txt


