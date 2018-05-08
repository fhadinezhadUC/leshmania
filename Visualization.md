#### Leishmanina genes mapped on Trypanosoma_cruzi_Dm28c.fasta using bowtie2 and Tablet

`
bowtie2-build -f  Trypanosoma_cruzi_Dm28c.fasta Trypanosoma_cruzi_Dm28c
`

`
bowtie2 --score-min 'C,0,-1' -x Trypanosoma_cruzi_Dm28c -f TryTrypDB_Aug2017_alltRNAs.tfam.fas -S aligned.sam
`

Inorder to get the perfect matches With bowtie2, you can either just use "grep AS:i:0" or just use the "--score-min 'C,0,-1'" option, which should do effectively the same thing.

`
samtools view -b -S -o aligned.bam aligned.sam
`

`
samtools sort aligned.bam aligned.sorted
`

`
samtools index aligned.sorted.bam
`

`
samtools tview aligned.sorted.bam Trypanosoma_cruzi_Dm28c.fasta Trypanosoma_cruzi_Dm28c.fasta
`

Tablet seems a better visualization tool!

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/tablet_genes_on_Trypanosoma_cruzi_Dm28c.3.png)
