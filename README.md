# 🚀 Azure VM (Linux) Deployment

The task was to deploy a single virtual machine in **Azure** using **Terraform**. To be able to ensure you can **SSH** into the VM. Once connected via SSH, create five directories named:  

- 🌅 Fajr  
- ☀️ Duhr  
- 🌤️ Asr  
- 🌇 Maghrib  
- 🌙 Isha  

---

## 💡 What I Learned

- ✅ How to create and manage Azure resources using **Terraform**  
- ✅ How to configure a **Network Security Group (NSG)** and add **inbound rules** for SSH access  
- ✅ How to **associate an NSG** with a subnet  
- ✅ How to use **`depends_on`** to control resource creation order  
- ✅ How to set up a **Virtual Network**, **Subnet**, **Public IP**, and **Network Interface**  
- ✅ How to deploy a **Linux VM** and connect via SSH  
- ✅ How to verify connectivity and perform tasks inside the VM (creating directories)

---

## ⚙️ Instructions

```bash
# Clone the repository
git clone <repo-url>
cd <repo-folder>

# Initialize Terraform
terraform init

# Get your IP address and then preview the deployment plan
terraform plan

# Apply the configuration
terraform apply

# SSH into the VM
ssh adminuser@<public-ip>

# Create the directories inside the VM
mkdir Fajr Duhr Asr Maghrib Isha
ls
