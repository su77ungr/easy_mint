


***
> 0. Prerequesites
 * I'm using Windows 10 with WSL (Windows Subsystem for Linux) https://www.microsoft.com/store/productId/9MSVKQC78PK6; to enable easy scripting with bash
 * Chia client >= 1.4.0 
 * NFT Collection in a seperate wallet
 




> 1. Setting up your environment
 * find your path on your local machine: /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon
 * it’s a bit long winded when most of your frequently accessed files are located there. Thankfully, we can use symlinks
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * you can `cd ~/chia` to access your linked directory; run `./chia.exe -h` to test everything is working as it should 
 * run `git clone this repo` inside the ~/chia folder
 * run `sudo chmod +x make_bulk_offers.sh`

 > 2. Everything should be ready to go!

 * note your `fingerprint`, `wallet ID (NFT)`, `wallet ID (Token)`
