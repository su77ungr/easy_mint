#!/bin/bash
for z in {1..999}
do
echo $i
sleep 1
uri_default=(https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph/$i.png)
echo uri url: $uri_default
uri_hash=$(sed -n ${i}p hashtable_URI.txt)
echo uri hash: $uri_hash
metadata_default=(https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata$i.json)
echo metadata url:$metadata_default
metadata_hash=$(sed -n ${i}p hashtable_MURI.txt)
echo metadata hash: $metadata_hash
echo "minting now ..."
sleep 2
./chia.exe wallet nft mint -f YOUR_FINGERPRINT -i 12 -ra YOUR_ADDRESS -ta YOUR_ADDRESS -u $uri_default -nh $uri_hash -mu $metadata_default -mh $metadata_hash -sn $i -st 999 -rp 420 -m 0.000615 &&
sleep 53
echo "minted $i"
done
