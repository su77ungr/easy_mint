#!/bin/bash

# NFT Images (images/) and NFT Metadata (metadata/) should be stored inside the easy_mint/ directory 

# URI storage link (i.e): https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph/69.png | you>URI=https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph
# URI local storage link (path to the directory where your images/files are stored)
FOLDER_NAME_URI=images

# MURI storage link (i.e): https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata69.json | you have>MURI=https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main
# URI local storage link (path to the directory where your metadata files are stored)
FOLDER_NAME_MURI=metadata

# Number of NFTs
NUM=9

# Number of NFTs (420 = 4.20%)
ROYALTY=420

for i in $(seq 1 $NUM);
do
sample1=$(sha256sum -b $FOLDER_NAME_URI/$i.png | cut -c -64) &&
sample2=$(curl -s $URI/$i.png | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match $(tput setaf 5) NFT Nr. $i ${sample1:0:5}...  ${sample2:0:5}...
echo $sample1 >> hashtable_URI.txt
else
echo $(tput setaf 1) DISMATCH at $i! $test2 --- $test3 >> hashtable_URI.log
fi
done
echo $(tput setaf 7) "hashtable_URI.txt created successfully"

# same procedure for the metadata
for i in $(seq 1 $NUM);
do
sample1=$(sha256sum -b $FOLDER_NAME_MURI/metadata$i.json | cut -c -64) &&
sample2=$(curl -s $MURI/metadata$i.json | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match $(tput setaf 5) NFT Nr. $i ${sample1:0:5}...  ${sample2:0:5}...
echo $sample1 >> hashtable_MURI.txt
else
echo $(tput setaf 1) DISMATCH at $i! $test2 --- $test3 >> hashtable_MURI.log
fi
done
echo $(tput setaf 7) "hashtable_MURI.txt created successfully"

