###############################################################################
# Use Terraform Version 0.12
# Obtain storage access_key from storage account or 
# az storage account keys list -g MyResourceGroup -n MyStorageAccount
# Linux:   export ARM_ACCESS_KEY=XXXXXYYYYYYY
# Windows: $env:ARM_ACCESS_KEY="XXXYYY"
###############################################################################
terraform {
    required_version = ">= 0.12"

    backend "azurerm" {
      # this key must be unique for each layer!
      storage_account_name = "rackspace2de2eaaa"
      container_name       = "terraform-state"
      key                  = "terraform.azurevm.tfstate"
    }
  }
# Locate the existing resource group
data "azurerm_resource_group" "main" {
  name = "Clarium-Project"
}

output "id" {
  value = data.azurerm_resource_group.main.id
}

# Locate the existing custom image
data "azurerm_image" "main" {
  name                = "myPackerImage-1633423501"
  resource_group_name = "Clarium-Project"
}

output "image_id" {
  value = "/subscriptions/93ab47bf-076c-43e0-9d6c-7c34fe77152a/resourceGroups/Clarium-Project/providers/Microsoft.Compute/images/myPackerImage-1633423501"
}

# Create a new Virtual Machine based on the custom Image
resource "azurerm_virtual_machine" "myVM2" {
  name                             = "myVM2"
  location                         = data.azurerm_resource_group.main.location
  resource_group_name              = data.azurerm_resource_group.main.name
  network_interface_ids            = ["${azurerm_network_interface.main.id}"]
  vm_size                          = "Standard_DS12_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = "${data.azurerm_image.main.id}"
  }

  storage_os_disk {
    name              = "myVM2-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
}

  os_profile {
    computer_name  = "APPVM"
    admin_username = "devopsadmin"
    admin_password = "admin@123"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  
  tags = {
    environment = "Production"
  }
}