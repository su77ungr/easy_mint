#!/bin/bash
for i in {20..400};
do
echo $i
id_list=$(sed -n ${i}p NFT1_BRICKS/NFTID_list.txt)
id_list2=${id_list::-1}
sleep 3
./chia.exe wallet make_offer -f 2788499092 -o $id_list2:1 -r 9:0.959692898273 -p offers/$i.offer &&
sleep 0.5
done
