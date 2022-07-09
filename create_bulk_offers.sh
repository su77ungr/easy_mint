#!/bin/bash
read -p "what's your fingerprint (i.e 278xxxxxxxxx)" finger
read -p "what's your Wallet ID for the NFTs? (i.e 5)" id
read -p "what's your Wallet ID for the tokens in exchange? (i.e 1)" id2
read -p "what's your NFT's royalty? (i.e 0.05 = 5% / 0.69 = 69%)" roy; neu=$(echo "$roy+1" | bc); neu2=$(echo "scale=3 ; 1 / $neu" | bc); echo $neu2
echo your royalty is $roy - ergo your exchange rate to token is $neu2
read -p "how many offers do you want to create?" num


./chia.exe wallet nft list -f $finger -i $id | grep "nft1" >> NFT_ID_LIST.txt
echo "your NFT IDs are stored in NFT_ID_LIST.txt"

read -p "$(tput setaf 2) Do you want to run auto creation of the offers? (yes/no) " yn
case $yn in
        yes ) echo ok, we will proceed;;
        no ) echo exiting...;
                exit;;
        * ) echo invalid response;
                exit 1;;
esac

echo "$(tput setaf 2) CREATING OFFERS NOW"

for i in $(seq 1 $num); do
./chia.exe wallet make_offer -f $finger -o $(sed -n ${i}p NFT_ID_LIST.txt | tail -c -64 | cut -c -62):1 -r $id2:$neu2 -p offers/$i.offer &&

sleep 0.5
done
echo "$(tput setaf 3)loop closed ... thank you for using my script. Follow me on the twiiter @chialisp"