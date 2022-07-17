#!/bin/bash
###        INPUT YOUR CREDENTIALS        ### 
############################################

#EXAMPLE could be jpg, jpeg too 
IMAGE_SUFFIX="png"
#EXAMPLE 1.png, 2.png ... eave it as it is / else enter "friend" for friend1.png, friend2.png ...
IMAGE_PREFIX="" 
#EXAMPLE
METADATA_SUFFIX="json"
#EXAMPLE for 1.json, 2.json ... leave it as it is / else enter "friend" for friend1.json, friend2.json ...
METADATA_PREFIX="metadata" 
#EXAMPLE stored inside images/ 
FOLDER_NAME_URI="images"    
#EXAMPLE stored inside metadata/ 
FOLDER_NAME_MURI="metadata"
#EXAMPLE Number of NFTs to mint 
NUM=9     
#EXAMPLE Royalty (420=4.20%) 
ROYALTY=420  
#EXAMPLE example
FINGERPRINT="1518460169"
#EXAMPLE your nft wallet's ID
WALLET_ID=12
#EXAMPLE receive address for the royalties 
ROYALTY_ADDRESS="txch1zgyhkjf90ducz0y35fsxsx48cc0k6zjzcpyj5zj0g0v8una6f9us6xg62l"   
#EXAMPLE receive address which the NFTs get sent to after minting 
RECEIVE_ADDRESS="txch1zgyhkjf90ducz0y35fsxsx48cc0k6zjzcpyj5zj0g0v8una6f9us6xg62l"
#EXAMPLE fee for every mint (0.0000615 XCH per NFT) 
FEE=0.000615 
#EXAMPLE api_key for nft.storage
API_KEY="eyJhbG......."

###  DO NOT TOUCH SCRIPT AFTER THIS LINE ### 
############################################

for i in $(seq 1 $NUM); do
#uploads images onto nft.storage
response1=$(curl -s -X POST https://api.nft.storage/upload -H "accept: application/json" -H "Content-Type: image/*" -H "Authorization: Bearer $API_KEY" --data-binary "@./$FOLDER_NAME_URI/$IMAGE_PREFIX$i.$IMAGE_SUFFIX" --stderr -);
cid1=`echo $response1 | jq -r '.value.cid'`
URI1="https://${cid1}.ipfs.nftstorage.link" &&

#uploads metadata onto nft.storage
response2=$(curl -s -X POST https://api.nft.storage/upload -H "accept: application/json" -H "Content-Type: image/*" -H "Authorization: Bearer $API_KEY" --data-binary "@./$FOLDER_NAME_MURI/$METADATA_PREFIX$i.$METADATA_SUFFIX" --stderr -);
cid2=`echo $response2 | jq -r '.value.cid'`
URI2="https://${cid2}.ipfs.nftstorage.link" &&

#hashes files (locally stored / online stored)
sample1_URI=$(sha256sum -b $FOLDER_NAME_URI/$IMAGE_PREFIX$i.$IMAGE_SUFFIX | cut -c -64) &&
sample2_URI=$(curl -s https://${cid1}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&
sample1_MURI=$(sha256sum -b $FOLDER_NAME_MURI/$METADATA_PREFIX$i.$METADATA_SUFFIX | cut -c -64) &&
sample2_MURI=$(curl -s https://${cid2}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&

#compares hashes
if [ $sample1_URI == $sample2_URI ] && [ $sample1_MURI == $sample2_MURI ]
then
echo $sample1_URI >> hashtable_URI.txt; echo $URI1 >> table_URI.txt
echo $sample1_MURI >> hashtable_MURI.txt; echo $URI2 >> table_MURI.txt
echo -e "NFT DATA Nr. $i"
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
#minting to the blockchain 
for i in $(seq 1 $NUM); do echo $(tput setaf 7)"MINTING $i ...";
echo "RUNNING: chia wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $(sed -n ${i}p table_URI.txt) -nh $(sed -n ${i}p hashtable_URI.txt) -mu $(sed -n ${i}p table_MURI.txt) -mh $(sed -n ${i}p hashtable_MURI.txt) -rp $ROYALTY -m $FEE"
echo "IF SOMETHING SEEMS WRONG; HIT CTRL+C"; sleep 5
chia wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $(sed -n ${i}p table_URI.txt) -nh $(sed -n ${i}p hashtable_URI.txt) -mu $(sed -n ${i}p table_MURI.txt) -mh $(sed -n ${i}p hashtable_MURI.txt) -rp $ROYALTY -m $FEE &&
sleep 69
done
