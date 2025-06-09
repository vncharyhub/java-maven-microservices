# 1. Install required packages
sudo apt update
sudo apt install curl unzip -y

# 2. Download AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# 3. Unzip the installer
unzip awscliv2.zip

# 4. Run the install script
sudo ./aws/install

# 5. Verify installation
aws --version

# 6. Clean Up After Install
rm -rf awscliv2.zip aws/
