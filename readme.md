<h1> Minting NFTs </h1>
 
 > <h3> 1. Prerequisites </h3>
 * Already generated Metadata in the <a href="https://github.com/Chia-Network/chips/blob/dc2e294b489ca0201a8e0f5ee9310650106bf7d2/assets/chip-0007/example.json"> CHIP-007 </a> format and uploaded files (preferably decentralized storage provider) for this demo: <a href="https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata69.json"> Raw Github </a>
 * Already uploaded Images (preferably decentralized storage provider) (in this example pinata.cloud) 
  <a href="https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph"> IPFS </a>
 * Chia Client >= 1.4.0 
 
 <h1></h1>
 
 > <h3> 2. Make list of hashes (URI/MURI) </h3>
 
 * run `./get_hashtable_uri.sh` generates a list of the hashed values of the image files 
 * run `./get_hashtable_metadata.sh`  generates a list of the hashed values of the  metadata files 
 * those are stored in `hashtable_URI.txt` and `hashtable_MURI.txt`
 
 <h1></h1>
 
 
 > <h3> 3. Feed final bulk_mint script </h3>
  
 `./chia.exe wallet nft mint -f YOUR_FINGERPRINT -i YOUR_WALLET_ID -ra YOUR_ADDRESS_FOR_ROYALTIES -ta YOUR_ADDRESS_RECEIVE -u $uri_default -nh $uri_hash -mu $metadata_default -mh $metadata_hash -sn $i -st SERIES_AMOUNT -rp YOUR_ROYALTIES -m YOUR_FEE`

 add parameters inside ./bulk_mint.sh
 
 *  `-f YOUR_FINGERPRINT`,  
 *  `-i YOUR_WALLET_ID`,  
 *  `-ra YOUR_ADDRESS_FOR_ROYALTIES`, 
 *  `-ta YOUR_ADDRESS_RECEIVE`,  
 *  `-st SERIES_AMOUNT`,
 *  `-rp YOUR_ROYALTIES (420 = 4.20%)`,
 *  `-m YOUR_FEE` and enter it when requested by the script
   
  * run `./bulk_mint.sh`


<h1> Automating .offer files (NFT <---> CAT)</h1>



> <h3> 1. Prerequisites </h3>
 * For <a href="https://www.microsoft.com/store/productId/9MSVKQC78PK6"> WSL </a> (Windows Subsystem for Linux) use: <a href="https://github.com/su77ungr/easy_mint/blob/main/create_bulk_offers.sh">create_bulk_offers.sh </a>
 * For native linux use: <a href="https://github.com/su77ungr/easy_mint/blob/main/create_bulk_offers_linux.sh">create_bulk_offers_linux.sh </a>
 * Chia Client >= 1.4.0 
 * NFT Collection in a separate wallet
 
<h1> </h1>


> <h3> 2. Setting up your environment</h3>
 * with WSL path should be: /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon
 * to simplify this path, we can use symlinks
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * `cd ~/chia` to access the newly linked directory; run `./chia.exe -h` to test everything is working as it should 
 * run `git clone https://github.com/su77ungr/easy_mint.git` inside it and  `cd easy_mint/`
 * run `sudo chmod +x create_bulk_offers.sh && mv create_bulk_offers.sh ~/chia`

 
<h1> </h1>

> <h3> 3. Everything should be ready to go!</h3>

 note your 
 *  `fingerprint`, 
 *  `wallet ID (NFT)`, 
 *  `wallet ID (Token)`,
 *  `Royalty (NFT)` and enter it when requested by the script

 run `sudo ./make_bulk_offers.sh` inside ~/chia
 * your offers will be stored inside `cd offers/` - you can upload them on https://dexie.space/upload
 
 <h1> </h1>
 END OF README
 
