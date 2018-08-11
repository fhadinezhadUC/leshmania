### Finding the intron frequency in the TriTryp genes

* By looking at the Gene Length Distribution we see how many of them are more likely to have introns.

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/GeneLengthDistribution.svg)
[script](https://github.com/fhadinezhadUC/leshmania/blob/master/GeneLength.R)

  * The shortest tRNA: TriTrypDB-33_TcruzimarinkelleiB7_Genome_21

  * The longest tRNA: TriTrypDB-33_TvivaxY486_Genome_34

* Conditions for considering a sequence as insertion:

   * In the arms: it should not be mapped to any arrow in the Consensus Structure

   * In the loops: it should be lowercase 

* The Consensus Structure for our data based on #=CS line in the alignment file was:
```
>>>>>>>  >>>>  <<<<  >>>>> <<<<<  >>>>> <<<<< <<<<<<<
```

* I parsed the "TryTrypDB_Aug2017_alltRNAs.tfam.covea" file based on this Structure and Sprinzl as references to assign the locations to each insertion. You can find the script [here](https://github.com/fhadinezhadUC/leshmania/blob/master/intronDist.R)


   
* Here is a brief summery of insertion Distribution of our Tri-Tryp Data :

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/InsertionLengthDist.jpeg)

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/insertionlocationdist.jpeg)

Also, a summary of intron Distribution found by tRNAScan: 
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/tseIntronLengthDist.jpeg)
![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/tseIntronLocationDist.jpeg)

The introns found by tse is a subset of insertions we found from covea alignment file. 

You can find a summery of introns found by tse in file [insertionAndIntron.txt](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/insertionAndIntron.txt)

Also, a set of these intons in file [SetOfinsertionAndIntron.txt](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/SetOfinsertionAndIntron.txt)

Also, a summery of insertions that were not considered as intron by tse can be found in file [insertionsNotintron.txt](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/insertionsNotintron.txt)  

and the set of these insertions in file [SetOfinsertionsNotintron.txt](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/SetOfinsertionsNotintron.txt)

NOTE: We were not able to find extract the intron sequence for genes "Trypanosoma_cruzi_strain_CL_Brener_78" and "Trypanosoma_cruzi_strain_CL_Brener_52" with the given coordinates!
