# Create a resource group for the application
resource "azurerm_resource_group" "app_rg" {
  name     = "kari0117-a12-rg"
  location = "westus3"
}