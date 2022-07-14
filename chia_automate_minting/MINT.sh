#!/bin/bash
 
###        INPUT YOUR CREDENTIALS        ### 
############################################

FILE_TYPE_OF_IMAGES="png" #could be jpg, jpeg too
#named 1.PNG, 2.PNG ... 1377.PNG and stored inside images/
FOLDER_NAME_URI="images"    
#named 1.JSON, 2.JSON ... 1377.JSON and stored inside metadata/
FOLDER_NAME_MURI="metadata"
#Number of NFTs to mint
NUM=9     
#Royalty (420=4.20%)
ROYALTY=420  
#example
FINGERPRINT=""
#your nft wallet's ID
WALLET_ID=12
#receive address for the royalties 
ROYALTY_ADDRESS=""   
#receive address which the NFTs get sent to after minting 
RECEIVE_ADDRESS=""
#fee for every mint (0.0000615 XCH per NFT)
FEE=0.000615 
#example
API_KEY=""

###  DO NOT TOUCH SCRIPT AFTER THIS LINE ### 
############################################

for i in $(seq 1 $NUM); do
#uploads images onto nft.storage
fname1="./$FOLDER_NAME_URI/$i.$FILE_TYPE_OF_IMAGES"
response1=$(curl -s -X POST https://api.nft.storage/upload -H "accept: application/json" -H "Content-Type: image/*" -H "Authorization: Bearer $API_KEY" --data-binary "@$fname1" --stderr -);
cid1=`echo $response1 | jq -r '.value.cid'`
URI1="https://${cid1}.ipfs.nftstorage.link"

#uploads metadata onto nft.storage
fname2="./$FOLDER_NAME_MURI/metadata$i.json"
response2=$(curl -s -X POST https://api.nft.storage/upload -H "accept: application/json" -H "Content-Type: image/*" -H "Authorization: Bearer $API_KEY" --data-binary "@$fname2" --stderr -);
cid2=`echo $response2 | jq -r '.value.cid'`
URI2="https://${cid2}.ipfs.nftstorage.link" &&

#hashes local files 
sample1_URI=$(sha256sum -b $FOLDER_NAME_URI/$i.$FILE_TYPE_OF_IMAGES | cut -c -64) &&
sample2_URI=$(curl -s https://${cid1}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&
sample1_MURI=$(sha256sum -b $FOLDER_NAME_MURI/metadata$i.json | cut -c -64) &&
sample2_MURI=$(curl -s https://${cid2}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&

#compares locally hashed files with the hash of uploaded files _ must be the same 
if [ $sample1_URI == $sample2_URI ] && [ $sample1_MURI == $sample2_MURI ]
then
echo $sample1_URI >> hashtable_URI.txt; echo $URI1 >> table_URI.txt
echo $sample1_MURI >> hashtable_MURI.txt; echo $URI2 >> table_MURI.txt
echo "NFT DATA Nr. $i"
echo $(tput setaf 2)HASHES MATCH$(tput setaf 7) URI : ${sample1_URI:0:7} --- ${sample2_URI:0:7}  --- ${URI1}
echo $(tput setaf 2)HASHES MATCH$(tput setaf 7) MURI: ${sample1_MURI:0:7} --- ${sample2_MURI:0:7} --- ${URI2}
else
echo $(tput setaf 1)HASHES DISMATCH at $i! "check credentials!" && echo NFT Nr. $i $URI1 - $sample_URI ; $URI2 - $sample_MURI >> minting.log; exit 
fi; done

echo "" && echo -e "CHECK your credentials! \n Fingerprint: $FINGERPRINT\n Wallet ID: $WALLET_ID\n Receive addrss (Royalties): $ROYALTY_ADDRESS\n Receive address (NFTs): $RECEIVE_ADDRESS\n Royalty (420=4.20%): $ROYALTY\n Fee: $FEE\n Amount to be minted: $NUM\n"
read -p "$(tput setaf 2)Do you want to start MINTING? (yes/ press anything else to exit) " yn
case $yn in
        yes ) echo proceed...;;
        * ) echo exiting...; exit 1;;
esac 
# minting to the blockchain 
for i in $(seq 1 $NUM); do echo $(tput setaf 7) "MINTING $i ...";
echo "RUNNING: chia wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $(sed -n ${i}p table_URI.txt) -nh $(sed -n ${i}p hashtable_URI.txt) -mu $(sed -n ${i}p table_MURI.txt) -mh $(sed -n ${i}p hashtable_MURI.txt) -rp $ROYALTY -m $FEE""
chia wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $(sed -n ${i}p table_URI.txt) -nh $(sed -n ${i}p hashtable_URI.txt) -mu $(sed -n ${i}p table_MURI.txt) -mh $(sed -n ${i}p hashtable_MURI.txt) -rp $ROYALTY -m $FEE" &&
sleep 66
done
