terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.69.0"
    }
  }
}
