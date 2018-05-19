#!/bin/bash
# remove the first line of the file flankingpositions.txt
while read line 
do
start=0
end=0
seqname=$(echo "$line" | awk '{print $3}')
end=$(($(echo "$line" | awk '{print $4}')+0))

start=$(( $end - 10000 ))
name=$(echo "$seqname" | tr -d '"')

samtools faidx Leishmania_infantum_JPCM5.fasta $name:$start-$end > flankingseq.fasta
bowtie2 -x ../reference/Leishmania_donovani_BPK282A1 -f flankingseq.fasta -S aligned.sam
samtools view -S -b aligned.sam > aligned.bam
samtools view aligned.bam > aligned.txt
leftcoordinate=$(awk '{print $3,$4}' < aligned.txt)
echo $leftcoordinate
leftcoordinatearr[$i]="$leftcoordinate"

# do the same think for the right flanking region 
start=0
end=0
seqname=$(echo "$line" | awk '{print $3}')
start=$(($(echo "$line" | awk '{print $5}')+0))
end=$(( $start + 10000 ))
name=$(echo "$seqname" | tr -d '"')

samtools faidx Leishmania_infantum_JPCM5.fasta $name:$start-$end > flankingseq.fasta
bowtie2 -x ../reference/Leishmania_donovani_BPK282A1 -f flankingseq.fasta -S aligned.sam
samtools view -S -b aligned.sam > aligned.bam
samtools view aligned.bam > aligned.txt
rightcoordinate=$(awk '{print $3,$4}' < aligned.txt)
echo $rightcoordinate
rightcoordinatearr[$i]="$rightcoordinate"        
i=$((i+1))
done < infantumflankingpositions.txt

printf "%s\n" "${rightcoordinatearr[@]}" > rightflank_Leishmania_donovani_BPK282A1.txt
printf "%s\n" "${leftcoordinatearr[@]}" > leftflank_Leishmania_donovani_BPK282A1.txt
