#!/bin/bash

# NFT Images (images/) and NFT Metadata (metadata/) should be stored inside the easy_mint/ directory

# URI storage link (i.e): https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph/69.png | you>URI=https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph
URI=https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph
# URI local storage link (path to the directory where your images/files are stored)
FOLDER_NAME_URI=images
# MURI storage link (i.e): https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata69.json | you have>MURI=https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main
MURI=https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main
# MURI local storage link (path to the directory where your metadata files are stored)
FOLDER_NAME_MURI=metadata
# Number of NFTs
NUM=9
# Number of NFTs (420 = 4.20%)
ROYALTY=420
# Receive Address (royalties)
ROYALTY_ADDRESS=txch1srfpkw8rfcxzt37the4xtunld5en4ac5mp92duxerlpf2t4u9rhqyv4pfq
# Receive address (NFTs)
RECEIVE_ADDRESS=txch1srfpkw8rfcxzt37the4xtunld5en4ac5mp92duxerlpf2t4u9rhqyv4pfq
###
###
# input field for credentials ends here 
###
###

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

# starting final mint script 

echo ""
echo $(tput setaf 7) "Everything is ready to mint"
read -p "$(tput setaf 2)Do you want to start MINTING? (yes/no) " yn
case $yn in
        yes ) echo proceed...;;
        no ) echo exiting...;
                exit;;
        * ) echo invalid response;
                exit 1;;
esac 
for i in $(seq 1 $NUM);
do
echo $i
echo URI: $URI/$i.png
URI_HASH=$(sed -n ${i}p hashtable_URI.txt); echo $URI_HASH
echo MURI: $MURI/metadata$i.json
MURI_HASH=$(sed -n ${i}p hashtable_MURI.txt); echo $MURI_HASH

echo $(tput setaf 7) "MINTING $i ..."
sleep 2
cd .. && ./chia.exe wallet nft mint -f YOUR_FINGERPRINT -i 12 -ra YOUR_ADDRESS -ta YOUR_ADDRESS -u $URI/$i.png -nh $URI_HASH -mu  $MURI/metadata$i.json -mh $MURI_HASH -sn 1 -st 1 -rp $ROYALTY -m 0.000615 && cd easy_mint/
sleep 53
done
