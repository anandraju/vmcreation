provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "devops_rg" {
  name     = "devops_rg"
  location = var.location
}

resource "azurerm_image" "image" {
  name     = var.imagename
  location = "East US"
  resource_group_name = azurerm_resource_group.devops_rg.name
  #source_virtual_machine_id = "/subscriptions/5a8d2bcf-85f4-4625-a08e-162fcb039c1a/resourceGroups/devops_rg/providers/Microsoft.Compute/virtualMachines/Devops_VM"
  source_virtual_machine_id = azurerm_virtual_machine.Devops_VM.id
}

output "vm_id" {
  value = azurerm_virtual_machine.Devops_VM.id
}

resource "azurerm_resource_group" "devops_vmss_ado" {
  name     = "devops_vmss_ado"
  location = var.location
}
