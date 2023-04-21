provider "azurerm" {
  features {

  }

}
resource "azurerm_resource_group" "funtion-rg" {
  name     = "funtion-app-rg"
  location = "South India"
}
resource "azurerm_storage_account" "funtion-storage" {
  name                     = "funtionappstorage3010"
  resource_group_name      = azurerm_resource_group.funtion-rg.name
  location                 = azurerm_resource_group.funtion-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
resource "azurerm_service_plan" "funtion-app-service-plan" {
  name                = "funtion-app-service-plan"
  resource_group_name = azurerm_resource_group.funtion-rg.name
  location            = azurerm_resource_group.funtion-rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}
resource "azurerm_linux_function_app" "funtion-app" {
  name                       = "funtion-app-trigger-1"
  resource_group_name        = azurerm_resource_group.funtion-rg.name
  location                   = azurerm_resource_group.funtion-rg.location
  storage_account_name       = azurerm_storage_account.funtion-storage.name
  storage_account_access_key = azurerm_storage_account.funtion-storage.primary_access_key
  service_plan_id            = azurerm_service_plan.funtion-app-service-plan.id
  site_config {
    application_stack {
      python_version = "3.10"
    }
  }

}
