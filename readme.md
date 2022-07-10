<h1> Minting NFTs </h1>
 
 > <h3> 1. Prerequisites </h3>
 * Metadata in <a href="https://github.com/Chia-Network/chips/blob/dc2e294b489ca0201a8e0f5ee9310650106bf7d2/assets/chip-0007/example.json"> CHIP-0007 </a> format (JSON) (preferably decentralized storage provider) for this demo: <a href="https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata69.json"> Raw Github </a>
 * Images (preferably decentralized storage provider)
  <a href="https://gateway.pinata.cloud/ipfs/QmVxrncdNzefaZQAmvNsP3ovpQCvPrAzeuoVqDYFDEEeph"> IPFS </a>
 * Chia Client >= 1.4.0 
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * `cd ~/chia` to access the newly linked directory; run `./chia.exe -h` to test everything is working as it should 
 
 <h1></h1>
 
 > <h3> 2. Equip MINT.sh with your Credentials </h3>
 * run `git clone https://github.com/su77ungr/easy_mint.git` inside it and `cd easy_mint/ && sudo chmod +x MINT.sh`
 * enter your credentials inside `MINT.sh` with `sudo MINT.sh`
add credentials inside on top of the script 
 
 *  `-f FINGERPRINT`,  
 *  `-i WALLET_ID`,  
 *  `-ra ROYALTY_ADDRESS`, 
 *  `-ta RECEIVE_ADDRESS`,  
 *  `-st SERIES_AMOUNT` note: use ❗1 on the default if you don't want several copys of the same NFT,
 *  `-sn SERIES_NUMBER` note: use ❗1 on the default if you don't want several copys of the same NFT,
 *  `-rp ROYALTIES (420 = 4.20%)`,
 *  `-m  FEE` 

 * run `MINT.sh` generates two .txt files: `hashtable_URI.txt` and `hashtable_MURI.txt` which are called in the mint function
 * run `sudo ./MINT.sh`
 
 <h1></h1>


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
 
