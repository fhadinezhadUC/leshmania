#!/bin/bash
# This script will that all the .fasta files and Match the name of the files with the name of the sequence in the first line of the file between the second | | letter. also, if there is any "/" in the name, it will convert it to "_"

yourfilenames=$(ls *.fasta)
for FILE in $yourfilenames; do
	myname=$(head -n 1 "${FILE}" | awk '{ c=1;newname="";for(i=1; i < NF; i++){if(match($i, "\|") && (c==1)){start=i;c = c+1;} else if(match($i, "\|") && (c==2)){end = i;c=c+1}} newname=$(start+1);for( i= start+2 ; i < end ; i++){newname = newname"_"$i } print newname".fasta"}') 
	finalname=${myname#*=}
	last=$(echo "$finalname" | tr "/" "_")
	mv "${FILE}" "$last"
done


