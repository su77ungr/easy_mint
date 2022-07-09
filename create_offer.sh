#!/bin/bash
read -p "what's your fingerprint (i.e 278xxxxxxxxx) - you can get it by ./chia.exe wallet show?" finger
read -p "what's your Wallet ID? (i.e 5)" id
./chia.exe wallet nft list -f $finger -i $id | grep "nft1" >> NFT_ID_LIST.txt

for i in {1..9}; do 
./chia.exe wallet make_offer -f $finger -o $(sed -n ${i}p NFT_ID_LIST.txt | tail -c -64 | cut -c -62):1 -r 9:0.959692898273 -p offers/$i.offer
done
