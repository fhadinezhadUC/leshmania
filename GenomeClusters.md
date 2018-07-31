Since the range of our clusters (positions) was wide, I was not able to show them in one plot to be able to see the tRNA gene array spacing. So, I ended up showing each cluster in one plot for each genome. 

Here is three examples for genome "infantum" and two genomes that I found the best sequenced genomes from genomecomparison plot: "Trypanosoma_brucei_gambiense" and "Trypanosoma_evansi"


Infantum :

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/clusters_infantum.svg)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/Leishmania_infantum_JPCM5.jpg)

Trypanosoma_brucei_gambiense:

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/Trypanosoma_brucei_gambiense_clusters.svg)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/Trypanosoma_brucei_gambiense.jpg)

Trypanosoma_evansi:

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/Trypanosoma_evansi_clusters.svg)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/figures/Trypanosoma_evansi_strain.jpg)

Here is the [Script](https://github.com/fhadinezhadUC/leshmania/blob/master/geneorder.R).

By just looking at Trypanosoma_evans and Trypanosoma_brucei, we see how similar they are and how the order of genes in each cluster in preserved. Although there are single gene clusters in bruci such as KCTT that has moved to a different place in evansi.

Also, in cluster 13, in evansi, there are  IAAT and GCTG that are not in bruci! they might have been duplicated into the oposit strand!

CGCA is also duplicated in evansi in cluster 11 in the oposit strand.

We see that the only change here was suplication of three genes and transposition of one other gene! 
The next thing that I like to do now is to visualize the clusters in two genomes with anchors.
