#!/bin/bash
input="/home/fatemeh/leshmania/mainfolder/geneinfoDF.txt"
while IFS= read -r var
do
  sourceseq=$(echo "$var" | awk '{printf $10}' )
  geneID=$(echo "$var" | awk '{printf $3}')
  genebegin=$(($(echo "$var" | awk '{printf $6}' )+0))
  geneend=$(($(echo "$var" | awk '{printf $7}' )+0))
  ref=$(echo "$var" | awk '{printf $2}' )
  intronbegin=$(($(echo "$var" | awk '{printf $6}' )+0))
  intronend=$(($(echo "$var" | awk '{printf $7}' )+0))
  REFGENOME=$(echo "$ref" | tr "/" "_")
  intronindex=$(( $intronbegin - $genebegin + 1 ))
  direction=$(echo "$var" | awk '{printf $5}')
  echo "+"
  echo "$geneID"
  echo "$direction"

   if [ "$intronbegin" -eq 0 ]
    then
     echo "0"
     intronindex=0
   else 
     samtools faidx "${REFGENOME}.fasta" "$sourceseq":$intronbegin-$intronend
   fi
   echo "$intronindex"
done < "$input"
