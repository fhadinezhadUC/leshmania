#!/bin/bash
awk '{
	for(i=1; i<= NF; i++){
		if(match($i,"sourceorganism*"))
		{
		 names[$i]++
		 printf "%s ",$i
		}
		if(match($i,"sourceseq*"))
		{
		 printf "%s\n",$i
		}
		
	}

	

}' TryTrypDB_Aug2017_alltRNAs.tfam.fas

# to get unique lines use the fallowing command:
# sh sourceorganism.sh | sort |uniq > output.txt

