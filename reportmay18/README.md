#### Orthology detection of genome Leishmania_infantum_JPCM5

- First, I looked for a leishmania phylogenetic tree to pick a sample of genomes that are closely related to each other. So, I picked three genomes Leishmania_donovani_BPK282A1, Leishmania_donovani_strain_BHU_1220, and Leishmania_infantum_JPCM5
second, I extracted all the genes from our gene file "TryTrypDB_Aug2017_alltRNAs.tfam.fas" that were generated from these organisms, removed all the repeated gene sequences and put the result in genes.txt
Third, aligned genes.txt to three genomes and visualized them using Tablet. I saw almost in all the sequences that we had a gene aligned, there was at least one cluster of genes whose distance was way less that 10,000bp

So, I tried to find the orthologous genes of Leishmania_infantum_JPCM5 genes in other two genomes using the fallowing steps:
step1. finding clusters: each cluster can have x number of genes whose distance from their neighbor genes is less than 10k (we had 35 clusters in Leishmania_infantum_JPCM5)
step2. finding tight anchors around the clusters: Pick a 10k flanking region around each cluster and align it to the other genomes(donovani_BPK282A1 and donovani_strain_BHU_1220) and stored the alignment position if any available. 

stepp3. if two clusters are in each other’s tight anchors, we connect them together as a candidate for being orthogroups.


The result for genome Leishmania_infantum_JPCM5 is stored in files 1 to 35. each file is for one cluster(orthogroup)

I also verified the result  for the cluster 21 using tablet. 
These three pictures are the genes aligned to three genomes for cluster 21.
the scripts are also available in "extractflankingseq.sh", "make_component.R", "make_Graph.R"
