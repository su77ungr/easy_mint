#!/bin/bash

for i in {1..999};
do
echo $i
uri_default=(https://ipfs.io/ipfs/QmdjvCJS5xuWsDFWzfHP6twRgAuVjmnipJqf4h9fRwvVqF/$i.png); echo uri url: $uri_default
uri_hash=$(sed -n ${i}p NFT1_BRICKS/uri_hash_ab444.txt); echo uri hash: $uri_hash
metadata_default=(https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata$i.json); echo metadata url:$metadata_default
metadata_hash=$(sed -n ${i}p NFT1_BRICKS/metadata_hash.txt); echo metadata hash: $metadata_hash
echo "minting now ..."

curl -s $uri_default | sha256sum
if [ ! -f "$uri_hash" ]; then
works

sleep 3
./chia.exe wallet nft mint -f 2788499092 -i 12 -ra xch1jvcz4kn2rue95sk3v2pf595ecpt343r7sgp4e5y5ndxtnp32rpxqamvcs3 -ta xch1pey8lcsxgchcszvqsphpx7mxweajepnvusd3ge7v2peey0skn0csh4>sleep 1
echo "mint ok"
done


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
