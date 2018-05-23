#### Orthology detection of genome Leishmania_infantum_JPCM5

- First, I looked for a leishmania phylogenetic tree to pick a sample of genomes that are closely related to each other. 
So, I picked three genomes Leishmania_donovani_BPK282A1, Leishmania_donovani_strain_BHU_1220, and Leishmania_infantum_JPCM5.

- Second, I extracted all the genes from our gene file "TryTrypDB_Aug2017_alltRNAs.tfam.fas" that were generated from these organisms, removed all the repeated gene sequences and put the result in genes.txt.

- Third, aligned genes.txt to three genomes and visualized them using Tablet. I saw almost in all the sequences(contigs) of three genomes where there was atleast two genes aligned, there was at least one cluster of genes.

- So, I tried to find the orthologous genes of Leishmania_infantum_JPCM5 genes in other two genomes (Leishmania_donovani_BPK282A1, Leishmania_donovani_strain_BHU_1220) using the fallowing steps:

** step1. finding clusters: each cluster can have x number of genes whose distance from their neighbor genes is less than 10k (we had 35 clusters in Leishmania_infantum_JPCM5)

** step2. finding tight anchors around the clusters: Pick a 10k flanking region around each cluster and align it to the other genomes(donovani_BPK282A1 and donovani_strain_BHU_1220) and stored the alignment position if any available. 

** step3. if two clusters are in each other’s tight anchors, we connect them together as a candidate for being orthogroups.


The result for the genome Leishmania_infantum_JPCM5 is stored in files 1 to 35 in infantumortholog folder. each file is for one cluster(orthogroup)

I also verified the result for the cluster 21 using tablet. 

These three pictures are the genes aligned to three genomes for cluster 21.

The scripts are also available in "extractflankingseq.sh", "make_component.R", "make_Graph.R"

Leishmania_donovani_BPK282A1
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/reportmay18/figures/se21donovi_BP2.png)

Leishmania_donovani_strain_BHU_1220
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/reportmay18/figures/set21donovi_strain.png)

Leishmania_infantum_JPCM5
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/reportmay18/figures/set21infantum.png)


The next things to do are:

- Use the protein coding regions to make the anchors tigher.
- Doing a many to many alignment for each cluster  using a defined genomic distance (dependent on the genomes distance on phylogenetic tree, the number of genes in the same cluster, the distance between the genes in cluster, etc.)
- Finding an anchor for those clusters whose 10k flanking region was not alignable (by probably doing a local alignment for a 100k or more region around the cluster.) 
