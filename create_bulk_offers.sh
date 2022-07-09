#!/bin/bash
sudo apt-get install bc -y &&
read -p "Enter your fingerprint (i.e 278xxxxxxxxx) :" finger
read -p "Wallet ID for the NFTs? (i.e 5) :" id
read -p "Wallet ID for the token you request? (i.e 2) :" id2
read -p "NFT's royalty? (i.e 0.05 = 5%) :" roy; neu=$(echo "$roy+1" | bc); neu2=$(echo "scale=3 ; 1 / $neu" | bc)
echo your royalty is $roy - ergo your exchange rate to token is $neu2
read -p "Amount of offers you want to create? :" num
echo ""
echo "creating NFT ID list now ..."
./chia.exe wallet nft list -f $finger -i $id | grep "nft1" >> NFT_ID_LIST.txt
echo "your NFT IDs are stored in NFT_ID_LIST.txt"
read -p "$(tput setaf 2)Do you want to start auto creating offers? (yes/no) " yn
case $yn in
        yes ) echo proceed...;;
        no ) echo exiting...;
                exit;;
        * ) echo invalid response;
                exit 1;;
esac
for i in $(seq 1 $num); do
sleep 1
yes | ./chia.exe wallet make_offer -f $finger -o $(sed -n ${i}p NFT_ID_LIST.txt | tail -c -64 | cut -c -62):1 -r $id2:$neu2 -p offers/$i.offer &&
sleep 0.5
done
echo "$(tput setaf 3)loop closed ... offers are saved in offers/  ... Please consider following me on the twitter @chialisp"
