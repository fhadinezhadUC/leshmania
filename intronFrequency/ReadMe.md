### Finding the intron frequency in the TryTryp genes

- First, By looking at the Gene Length Distribution we see how many of them are more likely to have introns.

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/GeneLengthDistribution.svg)
[script](https://github.com/fhadinezhadUC/leshmania/blob/master/GeneLength.R)

The shortest tRNA: TriTrypDB-33_TcruzimarinkelleiB7_Genome_21

The longest tRNA: TriTrypDB-33_TvivaxY486_Genome_34

- Conditions for considering a sequence as intron:

In the arms: it should not be mapped to any arrow in the Consensus Structure

In the loops: it should be lowercase 

- The Consensus Structure for our data was:
```
>>>>>>>  >>>>  <<<<  >>>>> <<<<<  >>>>> <<<<< <<<<<<<
```

So, I parsed the "TryTrypDB_Aug2017_alltRNAs.tfam.covea" file based on this Structure and Sprinzl as reference to assign the locations to each intron

You can find the script [here](https://github.com/fhadinezhadUC/leshmania/blob/master/intronDist.R)

- Here is a brief summery of intron Distribution of our Tri-Tryp Data :

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/IntronLengthDist.svg)

![alt text](https://github.com/fhadinezhadUC/leshmania/blob/master/intronFrequency/intronlocationdist.svg)

