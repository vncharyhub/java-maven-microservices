# 1. Update and install dependencies
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

# 2. Add HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# 3. Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# 4. Install Terraform
sudo apt update
sudo apt install terraform -y

# 5. Verify installation
terraform -v
