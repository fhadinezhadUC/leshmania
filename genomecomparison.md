
Camparing genomes by two factors for each genome :


- sequence count comparison (blue bar in plot) = (number of sequences in the genome/length of genome)*average length of all genomes
- sequence length comparison (red bar in the plot) = (average length of sequences in the genome / length of genome) * 100000

[Script](https://github.com/fhadinezhadUC/leshmania/blob/master/genomecomparison.R)

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/genomecomparison.svg)

So, those with lowest blue bar and highest red bar are those that are well sequenced. 
for example, as we see from the plot the genome 25 which is "Trypanosoma_brucel_gambience" is well sequence. Also, by looking at the SourceSO for genes that come from this genome we see that all of them are considered "chromosomes".
Note: I could not use the field "sourceSO" which has the values of: contig, supercontig and chromosome to compare the genomes because not all of the genes had this field!
