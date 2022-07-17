###        INPUT YOUR CREDENTIALS        ###
############################################
#EXAMPLE
FOLDER_NAME_URI="images"
#EXAMPLE stored inside metadata/
FOLDER_NAME_MURI="metadata"
#EXAMPLE Number of NFTs to mint
NUM=9
#EXAMPLE Royalty (420=4.20%)
ROYALTY=420
#EXAMPLE example
FINGERPRINT="1246490069"
#EXAMPLE your nft wallet's ID
WALLET_ID=2
#EXAMPLE receive address for the royalties
ROYALTY_ADDRESS="txch1zgyhkjf90ducz0y35fsxsx48cc0k6zjzcpyj5zj0g0v8una6f9us6xg62l"
#EXAMPLE receive address which the NFTs get sent to after minting
RECEIVE_ADDRESS="txch1zgyhkjf90ducz0y35fsxsx48cc0k6zjzcpyj5zj0g0v8una6f9us6xg62l"
#EXAMPLE fee for every mint (0.0000615 XCH per NFT)
FEE=0.000615
#EXAMPLE api_key for nft.storage ENTER YOUR API_KEY FIRST
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDE3N2VGNTMwMWQzZTQ0Mzg0MzhCNjNFMmVlRDI0OTI2QkU3ZDA3MjgiLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTY1NzQ2NTgwNjA1NSwibmFtZSI6Im1pbnQifQ.Cmc8U82mDx5A7y6dQyEabDk13d7IDKYYdrZnA5A2kQk"

###  DO NOT TOUCH SCRIPT AFTER THIS LINE ###
############################################

for i in $(seq 1 $NUM); do
#uploads images onto nft.storage
response1=$(curl -s -X POST https://api.nft.storage/upload -H "accept: application/json" -H "Content-Type: image/*" -H "Authorization: Bearer $API_KEY" --data-binary "@./$FOLDER_NAME_URI/$i.png" --stderr -) &&
cid1=`echo $response1 | jq -r '.value.cid'`
URI1="https://${cid1}.ipfs.nftstorage.link"

#uploads metadata onto nft.storage
response2=$(curl -s -X POST https://api.nft.storage/upload -H "accept: application/json" -H "Content-Type: image/*" -H "Authorization: Bearer $API_KEY" --data-binary "@./$FOLDER_NAME_MURI/$i.json" --stderr -) &&
cid2=`echo $response2 | jq -r '.value.cid'`
URI2="https://${cid2}.ipfs.nftstorage.link"

#hashes files (locally stored / online stored)
sample1_URI=$(sha256sum -b $FOLDER_NAME_URI/$i.png | cut -c -64) &&
sample2_URI=$(curl -s https://${cid1}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&
sample1_MURI=$(sha256sum -b $FOLDER_NAME_MURI/$i.json | cut -c -64) &&
sample2_MURI=$(curl -s https://${cid2}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&

#compares hashes
if [ $sample1_URI == $sample2_URI ] && [ $sample1_MURI == $sample2_MURI ]
then
echo $sample1_URI >> hashtable_URI.txt; echo $URI1 >> table_URI.txt
echo $sample1_MURI >> hashtable_MURI.txt; echo $URI2 >> table_MURI.txt
echo -e "NFT DATA Nr. $i\n"
echo $(tput setaf 2)HASHES MATCH$(tput setaf 7) URI : ${sample1_URI:0:7} --- ${sample2_URI:0:7}  --- ${URI1}
echo $(tput setaf 2)HASHES MATCH$(tput setaf 7) MURI: ${sample1_MURI:0:7} --- ${sample2_MURI:0:7} --- ${URI2}
else
echo $(tput setaf 1)HASHES DISMATCH at $i! "check credentials (i.e API KEY)!" && echo NFT Nr. $i $URI1 - $sample_URI ; $URI2 - $sample_MURI >> minting.log; exit
fi; done

echo "" && echo -e "CHECK your credentials! \n Fingerprint: $FINGERPRINT\n Wallet ID: $WALLET_ID\n Receive addrss (Royalties): $ROYALTY_ADDRESS\n Receive address (NFTs): $RECEIVE_ADDRESS\n Royalty (420=4.20%): $ROYALTY\n Fee: $FEE\n Amount to be minted: $NUM\n"
read -p "$(tput setaf 2)Do you want to start MINTING? (yes/ press anything else to exit) " yn
case $yn in
        yes ) echo proceed...;;
        * ) echo exiting...; exit 1;;
esac

u=$(sed -n ${i}p table_URI.txt);
nh=$(sed -n ${i}p hashtable_URI.txt);
mu=$(sed -n ${i}p table_MURI.txt);
mh=$(sed -n ${i}p hashtable_MURI.txt);
#minting to the blockchain
for i in $(seq 1 $NUM); do echo $(tput setaf 7)"MINTING $i ...";
echo "RUNNING: $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $u -nh $nh -mu $mu -mh $mh -rp $ROYALTY -m $FEE"
echo "IF SOMETHING SEEMS WRONG; HIT CTRL+C"; sleep 5
chia wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $u -nh $nh -mu $mu -mh $mh -rp $ROYALTY -m $FEE && cd test2/chia_automate_minting/ &&
sleep 69
done
