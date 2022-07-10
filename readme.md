
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
 
 <h1> Minting NFTs </h1>
 
 > <h3> 1. Prerequisites </h3>
 * Already generated Metadata in the CHIP-007 format and uploaded files (preferably decentralized storage provider)
 * Already uploaded Images (preferably decentralized storage provider) (in this example pinata.cloud) 
 * Chia Client >= 1.4.0 
 
 <h1></h1>
 
 > <h3> 2. Make list of hashes (URI/MURI) </h3>
 
 * run `./get_hashtable_uri.sh` inside it; you generated a list of the hashed values of the image files 
 * run `./get_hashtable_metadata.sh` inside it; you generated a list of the hashed values of the metadata files 
 * those are stored in `hashtable_URI.txt` and `hashtable_MURI.txt`
 <h1> </h1>
 > <h3> 3. Run final bulk script </h3>
  
 add parameters inside ./bulk_mint.sh
 
 *  `-f fingerprint`,  
 *  `-ra address to receive royalties`, 
 *  `-ta address to send the collection`,  
 *  `-st Amount of NFT in Series`,
 *  `-rp Amount of Royalties (420 = 4.20%)`,
 *  `-m transaction fee` and enter it when requested by the script
   
  * run `./bulk_mint.sh`

 END OF README
 
