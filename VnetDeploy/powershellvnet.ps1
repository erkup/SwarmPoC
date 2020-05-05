$resourceGroupName = "Management-RG"
$location = "EastUS2"
New-AzResourceGroup -Name $resourceGroupName -Location $location
Write-Host " Deploying Management VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/ManagementVNET.json
$resourceGroupName = "japaneast-RG"
$location = "JapanEast"
New-AzResourceGroup -Name $resourceGroupName -Location $location
Write-Host " Deploying Japan East region VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/Japan-East.json
$resourceGroupName = "EastUS2-RG"
$location = "EastUS2"
New-AzResourceGroup -Name $resourceGroupName -Location $location
Write-Host " Deploying EastUS2 region VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/EastUS2VNET.json
$resourceGroupName = "NorthEurope-RG"
$location = "NorthEurope"
New-AzResourceGroup -Name $resourceGroupName -Location $location
Write-Host " Deploying NorthEurope region VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/NorthEurope.json