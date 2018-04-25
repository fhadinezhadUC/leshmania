#!/bin/bash
# Script to extract the set of Organism from gene file 
# extract the lines that have sourceorganism field, then extract the source organism and put it in a array
awk '{
	for(i=1; i<= NF; i++){
		if(match($i,"sourceorganism*"))
		{
		 names[$i]++
		}
		
		
	}

	for(t in names)
	{
		print t
	}	

}' TryTrypDB_Aug2017_alltRNAs.tfam.fas

# Then, to get unique lines use the fallowing command:
# sh sourceorganism.sh | sort |uniq > output.txt


