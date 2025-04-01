terraform {

  required_version = "~> 1.5"

  # Specify the required providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.96.0"
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

provider "azurerm" {
  features {}
use_oidc = true
}
