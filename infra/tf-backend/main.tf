# Terraform block specifying required providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "tfstate_rg" {
  name     = "kari0117-githubactions-rg"
  location = "westus3" # Choose your preferred Azure region
}

# Create a storage account for Terraform state
resource "azurerm_storage_account" "tfstate_storage" {
  name                     = "kari0117githubactions"
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Enforce minimum TLS version
  min_tls_version = "TLS1_2"
}

# Create a container for Terraform state files
resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate_storage.name
  container_access_type = "private"
}

# Outputs to be used in GitHub Actions or other configurations
output "resource_group_name" {
  value = azurerm_resource_group.tfstate_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate_storage.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate_container.name
}

output "arm_access_key" {
  value     = azurerm_storage_account.tfstate_storage.primary_access_key
  sensitive = true
}