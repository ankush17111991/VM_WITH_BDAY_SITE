Azure VM Website Deployment using Terraform and Nginx
Overview
This project uses Terraform to provision an Azure Virtual Machine and deploy a simple static website using Nginx.

The website content is stored in index.html, and Nginx serves the webpage over HTTP.

Architecture

Developer
    |
    v
Terraform
    |
    v
Azure Virtual Machine
    |
    v
Install Nginx
    |
    v
Deploy index.html
    |
    v
Website served over HTTP
Technologies Used
Microsoft Azure
Terraform
Azure Virtual Machine
Nginx Web Server
HTML
Linux
Project Structure

.
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── index.html
└── README.md
Update the structure according to your actual Terraform files.

Prerequisites
An active Azure subscription
Terraform installed
Azure CLI installed
Git installed
Deployment Steps
1. Login to Azure

az login
az account show
2. Initialize Terraform

terraform init
3. Format and Validate Terraform

terraform fmt -recursive
terraform validate
4. Review the Infrastructure Plan

terraform plan
5. Deploy Azure Infrastructure

terraform apply
Review the proposed changes and type yes when prompted.

Nginx Website Configuration
The Azure VM is configured to install Nginx and serve the static website from index.html.

On an Ubuntu VM, Nginx can be installed using:


sudo apt-get update
sudo apt-get install -y nginx
Copy the website file to the default Nginx web directory:


sudo cp index.html /var/www/html/index.html
Start and enable Nginx:


sudo systemctl enable --now nginx
sudo systemctl status nginx
These commands can also be automated through Terraform VM custom data or a provisioning script, depending on the implementation in this repository.

Access the Website
After deployment, retrieve the VM's public IP address from the Terraform output or Azure portal.

Open the following URL in your browser:


http://<VM_PUBLIC_IP>
Ensure that the VM has a public IP address and that its Network Security Group permits inbound TCP traffic on port 80.

Security Scanning
Validate and scan the Terraform configuration before deployment:


terraform fmt -check -recursive
terraform init -backend=false
terraform validate
tflint --init
tflint
tfsec . || true
Review any security findings before deploying infrastructure.

Security Best Practices
Restrict inbound traffic through Network Security Groups.
Avoid exposing SSH access to the entire internet.
Use SSH keys instead of passwords where appropriate.
Keep the operating system and Nginx updated.
Use HTTPS with a valid TLS certificate for production websites.
Avoid committing credentials or sensitive Terraform state to Git.
Cleanup
To delete the infrastructure created by Terraform:
terraform plan -destroy
terraform destroy
Review the destruction plan before confirming.

Disclaimer
This project is intended for learning and demonstration purposes. Review the Terraform configuration and network security rules before using it in production.
