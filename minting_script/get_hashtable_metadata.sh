#!/bin/bash
for i in {0..999};
do

# you can download json folder from https://github.com/bricksofchia/NFT1_metadata to test this 
# hashing the local file / hashing the online path 
# if they match ; the hash gets saved in the table which we can later call on the final mint function

sample1=$(sha256sum -b metadata/metadata$i.json | cut -c -64) &&
sample2=$(curl -s https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata$i.json | sha256sum | cut -c -64) &&
echo $sample1
echo ""
echo $sample2
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match
echo $sample1 >> hashtable_MURI.txt
else
echo $(tput setaf 1) DISMATCH at $i! $test2 --- $test3 >> hashtable_MURI.log
fi
done
