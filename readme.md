


***
> 0. Goals 
 * Creating .offer files for redemption tokens (CATs) in exchange for an NFT
 * Automates this task
> 1. Prerequisites
 * Windows 11 with WSL (Windows Subsystem for Linux) https://www.microsoft.com/store/productId/9MSVKQC78PK6; for easy scripting with bash
 * Chia client >= 1.4.0 
 * NFT Collection in a seperate wallet
 




> 2. Setting up your environment
 * find your path on your local machine: /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon
 * it’s a bit long winded when most of your frequently accessed files are located there. Thankfully, we can use symlinks
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * you can `cd ~/chia` to access your linked directory; run `./chia.exe -h` to test everything is working as it should 
 * run `git clone https://github.com/su77ungr/easy_mint.git` inside the ~/chia folder and  `cd easy_mint`
 * run `sudo chmod +x create_bulk_offers.sh && mv create_bulk_offers.sh ~/chia`

 > 3. Everything should be ready to go!

 * note your `fingerprint`, `wallet ID (NFT)`, `wallet ID (Token)` and enter it when requested by the script
 * run `sudo ./make_bulk_offers.sh` inside ~/chia
