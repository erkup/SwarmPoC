Write-Host " Deploying VNETs and Required peerings"
#Starting Auditing of Install
Start-Transcript -path deploynetwork.txt

$tags = @{"Demo" = "Swarm"}
$resourceGroupName = "Management-RG"
$location = "EastUS2"
New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags

Write-Host " Deploying Management VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/ManagementVNET.json

$resourceGroupName = "japaneast-RG"
$location = "JapanEast"
New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags

Write-Host " Deploying Japan East region VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/Japan-East.json

$resourceGroupName = "EastUS2-RG"
$location = "EastUS2"
New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags

Write-Host " Deploying EastUS2 region VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/EastUS2VNET.json


$resourceGroupName = "NorthEurope-RG"
$location = "NorthEurope"
New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags

Write-Host " Deploying NorthEurope region VNET"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/shruthi-vijay/VNET-deployments/master/NorthEurope.json


#Create VNET peering

$mgmt = Get-AzVirtualNetwork -Name EastUS2-Mgmt-vnet -ResourceGroupName "Management-RG"
$eastus2 = Get-AzVirtualNetwork -Name EastUS2-vnet -ResourceGroupName "EastUS2-RG"
$japan = Get-AzVirtualNetwork -Name japaneast-vnet -ResourceGroupName "japaneast-RG"
$NorthEurope = Get-AzVirtualNetwork -Name northeurope-vnet -ResourceGroupName "NorthEurope-RG"

Write-Host "Peering From Mgmt to East US2"
Add-AzVirtualNetworkPeering -Name ManagementtoEastUS2  -VirtualNetwork $mgmt -RemoteVirtualNetworkId $eastus2.Id

Write-Host "Peering From East US2 to Mgmt"
Add-AzVirtualNetworkPeering -Name EastUS2toManagement -VirtualNetwork $eastus2 -RemoteVirtualNetworkId $mgmt.Id

Write-Host "Create Peering From Mgmt to JapanEast"
Add-AzVirtualNetworkPeering -Name ManagementtoJapan  -VirtualNetwork $mgmt -RemoteVirtualNetworkId $japan.Id

Write-Host "Create Peering From JapanEast to Mgmt"
Add-AzVirtualNetworkPeering -Name JapantoManagement -VirtualNetwork $japan -RemoteVirtualNetworkId $mgmt.Id

Write-Host "Create Peering From Mgmt to NorthEurope"
Add-AzVirtualNetworkPeering -Name ManagementtoNorthEurope -VirtualNetwork $mgmt -RemoteVirtualNetworkId $NorthEurope.Id

Write-Host "Create Peering From NorthEurope to Mgmt"
Add-AzVirtualNetworkPeering -Name NorthEuropetoManagement -VirtualNetwork $NorthEurope -RemoteVirtualNetworkId $mgmt.Id
