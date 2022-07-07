#!/bin/bash
for i in {20..400};
do
echo $i

id_list=$(sed -n ${i}p NFT1_BRICKS/NFTID_list.txt)

for i in {1..999}
do
echo $i
./chia.exe wallet nft list -i 12 | grep "nft1" | get number $i >> NFT_ID_LIST.txt


id_list2=${id_list::-1}
sleep 3
./chia.exe wallet make_offer -f 2788499092 -o $id_list2:1 -r 9:0.959692898273 -p offers/$i.offer &&
sleep 0.5
sudo apt-get install qrencode -y && \
raw_offer=$(sudo cat offers/$i.offer) && echo "$(tput setaf 2) $raw_offer" && qrencode $raw_offer -t ANSI256 | qrencode $raw_offer -t SVG > backup_qr$i.svg | echo "saved backup QR in backup_qr$i.svg" 
done
