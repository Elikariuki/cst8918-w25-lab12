terraform {
  # Specify the required providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }

  # Configure the backend to use Azure Storage
  backend "azurerm" {
    resource_group_name  = "kari0117-githubactions-rg"
    storage_account_name = "kari0117githubactions"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
    use_oidc             = true
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
  use_oidc = true
}