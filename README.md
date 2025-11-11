# Azure-VM-Deploy

Terraform configuration to deploy a single Azure Linux virtual machine with SSH access. After deployment, create five directories inside the VM: Fajr, Duhr, Asr, Maghrib, and Isha.

---

# 🚀 Terraform Azure VM Deployment

## 🎯 Task
Deploy a single virtual machine in **Azure** using **Terraform**. Ensure you can **SSH** into the VM. Once connected via SSH, create five directories named:  

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

**📝 Requirements:**  
- Only one VM.  
- Must be inside a resource group in Azure.  
- No extra guidance is provided — figure out the implementation yourself.  

**📦 Deliverables:**  
- Terraform configuration files.  
- Confirmation that the five directories exist inside the VM.  

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
