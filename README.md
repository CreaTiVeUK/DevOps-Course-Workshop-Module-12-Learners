# Workshop Module 12

This repository is for learners on Corndel's DevOps apprenticeship.

During workshop 12 you'll be following the instructions in [during_workshop_12.md](during_workshop_12.md).

## Pre-requisites

You need to have an Azure account. Contact a tutor if you do not have access to one.

Also, make sure you have installed the following:

* [Visual Studio Code](https://code.visualstudio.com/download)
* [Git](https://git-scm.com/)
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* [Terraform](https://www.terraform.io/downloads.html)
* [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)






az deployment group create --name m12deployment --resource-group StandardChartered21_SimeonPenev_Workshop --template-file template.json --parameters parameters.json --parameters administratorLoginPassword=bcs_mis@123 --parameters storageAccountKey=8UysDEq059/rABQjuAh3vqop71CazcJneHtL2Lzoxsuv71iGoWYT9VTUoH56vAk5+O4VJsYjatOtIUw9y+AWxA== --parameters importDatabase=true -c


az deployment show --name m12deployment --resource-group StandardChartered21_SimeonPenev_Workshop | jq '.properties.outputs'