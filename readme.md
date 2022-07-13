<h1> Automating .offer files</h1>



> <h3> 1. Prerequisites </h3>
 * Synced chia client >= 1.4.0 
 * NFTs / CATs inside a known wallet
 
<h1> </h1>

<details>
<summary><h3>  ❗ WINDOWS users - read dropdown! </h3> </summary>


 * For <a href="https://www.microsoft.com/store/productId/9MSVKQC78PK6"> WSL </a> (Windows Subsystem for Linux) use: <a href="https://github.com/su77ungr/easy_mint/blob/main/create_bulk_offers.sh">create_bulk_offers.sh </a>
 * with WSL path should be: /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon
 * to simplify this path, we can use symlinks
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * `cd ~/chia` to access the newly linked directory; run `./chia.exe -h` to test everything is working as it should 
 * use the create_bulk_offers.sh script for the next steps instead of create_bulk_offers_linux.sh❗

</details>
<br>

> <h3> 2. Setting up your environment</h3>

 * run `git clone https://github.com/su77ungr/easy_mint.git` inside it and  `cd easy_mint/`
 * run `sudo chmod +x create_bulk_offers_linux.sh && mv create_bulk_offers_linux.sh ~/chia`

 
<h1> </h1>

> <h3> 3. Everything should be ready to go!</h3>

 note your 
 *  `fingerprint`, 
 *  `wallet ID (NFT)`, 
 *  `wallet ID (Token)`,
 *  `Royalty (NFT)` and enter it when requested by the script

 run `sudo ./make_bulk_offers_linux.sh`
 
 * your offers will be stored inside `cd offers/` - you can upload them onto https://dexie.space/upload
 
 <br><br>











<h1> Minting NFTs (uploading, hashing and minting) </h1>
 
 > <h3> 1. Prerequisites </h3>
 * Metadata in <a href="https://github.com/Chia-Network/chips/blob/dc2e294b489ca0201a8e0f5ee9310650106bf7d2/assets/chip-0007/example.json"> CHIP-0007 </a> format (JSON) demo: <a href="https://raw.githubusercontent.com/bricksofchia/NFT1_metadata/main/metadata69.json"> here  </a>
 * Images (PNG format)
 * nft.storage API KEY get one <a href="https://nft.storage/"> here </a>
 * Synced chia client >= 1.4.0 
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * `cd ~/chia` to access the newly linked directory; run `./chia.exe -h` to test everything is working as it should 
 
 <h1></h1>
 
 > <h3> 2. Equip MINT.sh with your Credentials </h3>
 * run `git clone https://github.com/su77ungr/easy_mint.git` inside it and `cd easy_mint/ && sudo chmod +x MINT.sh`
 * note 
 
add credentials inside with `sudo nano MINT.sh`
 *  ` API_KEY`,  
 *  ` FOLDER_NAME_URI`, ` FOLDER_NAME_MURI`
 *  `FINGERPRINT`,  `WALLET_ID`,  `ROYALTY_ADDRESS`,   `RECEIVE_ADDRESS`,  `NUM`
 *  `-rp ROYALTY (420 = 4.20%)`,
 * ~~`-st SERIES_AMOUNT`~~ note: don't use this flag ❗if you don't want several copys of the same NFT,
 * ~~`-sn SERIES_NUMBER`~~ note: don't use this flag ❗if you don't want several copys of the same NFT

run `sudo ./MINT.sh`


<br><br>
 
 
