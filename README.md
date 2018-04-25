#### In order to map the genes to their genome:

- First, rename all the genome .fasta files to their sequence name from the first line of the .fasta file by running the [rename.sh script](https://github.com/fhadinezhadUC/leshmania/blob/master/editNames.sh).  

- Second, in order to do some preprocessing on the TryTrypDB_Aug2017_alltRNAs.tfam.fas file to revome the even lines (which is the gene sequence and is repeated in araquery field) using the fallowing code:

`
awk '{if(NR%2==1){print $0}}' TryTrypDB_Aug2017_alltRNAs.tfam.fas > temp.txt
`

- Then, remove ines that do not have the sourceorganism field. (we will deal with hese files later!) 

`
awk '{for(i=1; i < NF; i++){if(match($i,"sourceorganism*")){print $0; break;}}}' temp.txt > inputgenefile.txt
`

- Third, read the TryTrypDB_Aug2017_alltRNAs.tfam.fas file line by line and take each gene and using blast align it to its source organism genome. Then, make an output.txt file like the bellow using [alignseq.sh script](https://github.com/fhadinezhadUC/leshmania/blob/master/alignseq.sh).
```
Blechomonas_ayalai_B08-376|ggggatgtagctcaaatggtagagcgaccgcttagcatgcggtaggtattgggatcgatacccaacttctccatc|3 hits
212366 212440
133 205
1008 968
```
- Finally, using this output.txt file and [leishmania.R script](https://github.com/fhadinezhadUC/leshmania/blob/master/leishmania.R) we can get the fallowing diagrams to see how the data looks like.


* Frequency of identical genes (same organism, same color)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/genes2.jpeg)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/Genes.jpeg)


* Frequency of GeneOrganism. To see how many repeats of same gene with same source organism we have in the data. (same organism, same color)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/p1org.jpeg)


* Frequency of GeneOrganism. To see how many repeats of same gene with same source organism we have in the data. (same gene, same color)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/pgene.jpeg)


* Genes VS. Number of hits (same organism same colour )
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/NumberofHits.svg)



