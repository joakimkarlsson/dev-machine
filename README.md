# Steps to install on a minimal box

1. Update package list

`sudo apt update`

2. Install bare-bone essentials

`sudo apt install -y git`

3. Get machines repo

`git clone https://github.com/joakimkarlsson/machines.git`

4. Run the setup script

`sudo ./machines/provision.sh`
