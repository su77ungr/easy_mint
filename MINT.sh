#!/bin/bash
FOLDER_NAME_URI=images                                                              
FOLDER_NAME_MURI=metadata                                                            
NUM=9                                                                               
ROYALTY=420                                                                         
FINGERPRINT=278XXXXXXX 
WALLET_ID=12
ROYALTY_ADDRESS=txch1srfpkw8rfcxzt37the4xtunld5en4ac5mp92duxerlpf2t4u9rhqyv4pfq   
RECEIVE_ADDRESS=txch1srfpkw8rfcxzt37the4xtunld5en4ac5mp92duxerlpf2t4u9rhqyv4pfq  
API_KEY="{YOUR_API_KEY_FOR_NFT_STORAGE}"

for i in $(seq 1 $NUM); do
fname="./$FOLDER_NAME_URI/$i.png"

response=`curl -s -X 'POST' "https://api.nft.storage/upload" \
  -H "accept: application/json" \
  -H "Content-Type: image/*" \
  -H "Authorization: Bearer $API_KEY" \
  --data-binary "@$fname"`

cid=`echo $response | jq -r '.value.cid'`
URI="https://${cid}.ipfs.nftstorage.link" &&
echo $URI

sample1=$(sha256sum -b $FOLDER_NAME_URI/$i.png | cut -c -64) &&
sample2=$(curl -s https://${cid}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match $(tput setaf 5) NFT Nr. $i ${sample1:0:5}...  ${sample2:0:5}...
echo $sample1 >> hashtable_URI.txt
echo $URI >> table_URI.txt
else
echo $(tput setaf 1) DISMATCH at $i! $test2 --- $test3 >> hashtable_URI.log
fi
done
echo $(tput setaf 7) "hashtable_URI.txt created successfully"

# same for emtadata 

for i in $(seq 1 $NUM); do
fname="./$FOLDER_NAME_MURI/metadata$i.json"

response=`curl -s -X 'POST' "https://api.nft.storage/upload" \
  -H "accept: application/json" \
  -H "Content-Type: image/*" \
  -H "Authorization: Bearer $API_KEY" \
  --data-binary "@$fname"`

cid=`echo $response | jq -r '.value.cid'`
URI="https://${cid}.ipfs.nftstorage.link" &&
echo $URI

sample1=$(sha256sum -b $FOLDER_NAME_MURI/metadata$i.json | cut -c -64) &&
sample2=$(curl -s https://${cid}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match $(tput setaf 5) NFT Nr. $i ${sample1:0:5}...  ${sample2:0:5}...
echo $sample1 >> hashtable_MURI.txt
echo $URI >> table_MURI.txt
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

for i in $(seq 1 $NUM); do
URI=$(sed -n ${i}p table_URI.txt)
URI_HASH=$(sed -n ${i}p hashtable_URI.txt)
MURI=$(sed -n ${i}p table_MURI.txt)
MURI_HASH=$(sed -n ${i}p hashtable_MURI.txt)

echo $(tput setaf 7) "MINTING $i ..."
cd .. && ./chia.exe wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $URI -nh $URI_HASH -mu  $MURI -mh $MURI_HASH -rp $ROYALTY -m 0.000615 && cd easy_mint/
sleep 53
done
