#!/bin/bash
for i in {0..999};
do

# hashing the local file / hashing the online path https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph
# if they match ; the hash gets saved in the table which we can later call on the final mint function

sample1=$(sha256sum -b images/$i.png | cut -c -64) &&
sample2=$(curl -s https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph/$i.png | sha256sum | cut -c -64) &&
echo $sample1
echo ""
echo $sample2
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match
echo $sample1 >> hashtable_URI.txt
else
echo $(tput setaf 1) DISMATCH at $i! $test2 --- $test3 >> hashtable_URI.log
fi
done
