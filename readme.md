
<h1> Automating .offer files (NFT for CAT)</h1>



> <h3> 1. Prerequisites </h3>
 * For WSL (Windows Subsystem for Linux) https://www.microsoft.com/store/productId/9MSVKQC78PK6 <a href="https://github.com/su77ungr/easy_mint/blob/da56b4ba2931cec8cc2deb2ba8dabf5476794300/create_bulk_offers_linux.sh">use create_bulk_offers.sh </a>
 * For native linux: <a href="https://github.com/su77ungr/easy_mint/blob/da56b4ba2931cec8cc2deb2ba8dabf5476794300/create_bulk_offers_linux.sh">use create_bulk_offers_linux.sh </a>
 * Chia Client >= 1.4.0 
 * NFT Collection in a separate wallet
 
<h1> </h1>


>  <h3> 2. Setting up your environment</h3>
 * with WSL path should be: /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon
 * to simplify this path, we can use symlinks
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * `cd ~/chia` to access the newly linked directory; run `./chia.exe -h` to test everything is working as it should 
 * run `git clone https://github.com/su77ungr/easy_mint.git` inside it and  `cd easy_mint/`
 * run `sudo chmod +x create_bulk_offers.sh && mv create_bulk_offers.sh ~/chia`

 
<h1> </h1>

>  <h3> 3. Everything should be ready to go!</h3>

 note your 
 *  `fingerprint`, 
 *  `wallet ID (NFT)`, 
 *  `wallet ID (Token)`,
 *  `Royalty (NFT)` and enter it when requested by the script

 run `sudo ./make_bulk_offers.sh` inside ~/chia
 * your offers will be stored inside `cd offers/` - you can upload them on https://dexie.space/upload
 * END OF README
 
