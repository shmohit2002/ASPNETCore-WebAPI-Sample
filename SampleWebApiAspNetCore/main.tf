provider "azurerm" {
  subscription_id = "76212b90-b178-425e-829f-e8213a2066aa"
  features {}
}

resource "azurerm_resource_group" "trial" {
  name     = "trial-rg"
  location = "eastus"
}

# I have not added any tags so the below terraform should not be used in bigger use-case without modifications
resource "azurerm_container_registry" "trial" {
  name                     = "trialacr4ryn"
  resource_group_name      = azurerm_resource_group.trial.name
  location                 = azurerm_resource_group.trial.location
  sku                      = "Basic"
  admin_enabled            = true
}

resource "azurerm_kubernetes_cluster" "trial" {
  name                = "trial-dev-aks"
  location            = azurerm_resource_group.trial.location
  resource_group_name = azurerm_resource_group.trial.name
  dns_prefix          = "trial-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}