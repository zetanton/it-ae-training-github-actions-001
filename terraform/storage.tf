resource "azurerm_resource_group" "storage_rg" {
  name     = "it-ae-training-github-actions-001-${var.netid}"
  location = "South Central US"
}

resource "azurerm_storage_account" "training_sa" {
  name                     = "tamughtrn${var.netid}"
  resource_group_name      = azurerm_resource_group.storage_rg.name
  location                 = azurerm_resource_group.storage_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  lifecycle {
    ignore_changes = [
      tags["FAMIS Account"],
    ]
  }
}

resource "azurerm_storage_blob" "training_content_blobs" {
  for_each = fileset(path.module, "../web_content/*.html")

  name                   = trim(each.key, "../web_content/")
  storage_account_name   = azurerm_storage_account.training_sa.name
  storage_container_name = "$web"
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
  content_type           = "text/html"
}

