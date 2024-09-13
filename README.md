# Inception



## Notes

### MySQL Notes

- `mysql -u root -p mysql` 
    - To get into the mysql database.
- `select User, Host from mysql.user;`
    - To print the list of users in the database.


### Setup for Virtual Machine

- I started with the current release of Debian (12.7.0 Bookworm).
- `debian-12.7.0-amd64-netinst.iso`

- Then ran the following commands:
```bash
# Using superuser to add user (dpentlan) to the sudo group
su -
apt-get -y update
apt-get -y upgrade
apt install sudo
usermod -aG sudo dpentlan
getent group sudo
exit

# With this we're giving our users permissions.
sudo visudo

# Adding this line to visudo
dpentlan ALL=(ALL) ALL
# finish

# Install the basics for my server
sudo apt-get install -y git
git --version
sudo apt-get install -y vim
sudo apt-get install wget
sudo apt install openssh-server
systemctl status ssh

# Install docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

# Make it so that we dont need sudo with docker commands.
sudo gpasswd -a dpentlan docker
# sudo usermod -aG docker dpentlan # might not be necessary
newgrp docker # either run this or log out and back in. Whichever works.

# Install and configure firewall so that only connections are thorugh port 443
sudo apt-get update -y
sudo apt-get install ufw
sudo ufw app list
sudo ufw allow OpenSSH
sudo ufw allow 443
sudo ufw enable
sudo ufw status

# Create new key for github so we can clone the repo
ssh-keygen -t ed25519 -C "your_email@example.com"
# then take the file at ~/.ssh/key.pub and paste it in github.

```