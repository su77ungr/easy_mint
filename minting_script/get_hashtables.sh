#!/bin/bash

# URI storage link (i.e): https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph/69.png | you have to enter:
URI=https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph
# URI local storage link (i.e): /images
FOLDER_NAME_URI=images

# MURI storage link (i.e): https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata69.json | you have to enter: 
MURI=https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main
# URI local storage link (i.e): /images
FOLDER_NAME_MURI=metadata

# Number of NFTs 
NUM=999

for i in $(seq 1 $NUM);
do
sample1=$(sha256sum -b $FOLDER_NAME_URI/$i.png | cut -c -64) &&
sample2=$(curl -s $URI/$i.png | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match
echo $sample1 >> hashtable_URI.txt
else
echo $(tput setaf 1) DISMATCH at $i! $test2 --- $test3 >> hashtable_URI.log
fi
done
echo "hashtable_URI.txt created successfully"

# same procedure for the metadata 

for i in $(seq 1 $NUM);
do
sample1=$(sha256sum -b $FOLDER_NAME_MURI/metadata$i.json | cut -c -64) &&
sample2=$(curl -s $MURI/metadata$i.json | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match
echo $sample1 >> hashtable_MURI.txt
else
echo $(tput setaf 1) DISMATCH at $i! $test2 --- $test3 >> hashtable_MURI.log
fi
done
echo "hashtable_MURI.txt created successfully"
