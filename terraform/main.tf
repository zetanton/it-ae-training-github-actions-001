terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.67.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "github-workshop-tfstate"
    storage_account_name = "ditcscnaiptest002wstf"
    container_name       = "it-ae-training-github-actions-001-tfstate"
    # key                  = "bdd4329/terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}