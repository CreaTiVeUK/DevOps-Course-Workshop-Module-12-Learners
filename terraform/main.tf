terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "main" {
  name = "StandardChartered21_SimeonPenev_Workshop_M12_Pt2"
}

resource "azurerm_app_service_plan" "main" {
  name                = "simeon-terraformed-asp"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "simeon-terraformed-app-service"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|corndelldevopscourse/mod12app:latest"
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" : "True"
    "DEPLOYMENT_METHOD" : "Terraform"
    "CONNECTION_STRING" : "Server=tcp:simeonpenev-non-iac-sqlserver.database.windows.net,1433;Initial Catalog=simeonpenev-non-iac-db;Persist Security Info=False;User ID=dbadmin;Password=${var.database_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }

}

resource "azurerm_sql_server" "main" {
  name                         = "simeonpenev-non-iac-sqlserver"
  resource_group_name          = data.azurerm_resource_group.main.name
  location                     = data.azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.server_admin_username
  administrator_login_password = var.server_admin_pass

  tags = {
    environment = "development"
  }
}

resource "azurerm_sql_database" "main" {
  name                = "simeonpenev-non-iac-db"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  server_name         = azurerm_sql_server.main.name

}