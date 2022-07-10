#!/bin/bash

# NFT Images (images/) and NFT Metadata (metadata/) should be stored inside the easy_mint/ directory

# URI storage link (i.e)
URI=https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph 
# URI local storage link (directory your files are stored in)
FOLDER_NAME_URI=images                                                              
# MURI storage link (i.e)
MURI=https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main              
# URI local storage link (directory your files are stored in)
FOLDER_NAME_MURI=metadata                                                            
# Number of NFTs to be minted
NUM=9                                                                               
# Royalties (420 = 4.20%)
ROYALTY=420                                                                         
# Wallet's fingerprint
FINGERPRINT=278XXXXXXX 
# Wallet's ID 
WALLET_ID=12
# Receive Address (royalties)
ROYALTY_ADDRESS=txch1srfpkw8rfcxzt37the4xtunld5en4ac5mp92duxerlpf2t4u9rhqyv4pfq   
# Receive address (NFTs)
RECEIVE_ADDRESS=txch1srfpkw8rfcxzt37the4xtunld5en4ac5mp92duxerlpf2t4u9rhqyv4pfq      

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
URI_HASH=$(sed -n ${i}p hashtable_URI.txt)
MURI_HASH=$(sed -n ${i}p hashtable_MURI.txt)
echo $(tput setaf 7) "MINTING $i ..."
cd .. && ./chia.exe wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $URI/$i.png -nh $URI_HASH -mu  $MURI/metadata$i.json -mh $MURI_HASH -sn 1 -st 1 -rp $ROYALTY -m 0.000615 && cd easy_mint/
sleep 53
done
