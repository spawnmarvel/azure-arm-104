$vnet = "vnet004799"
# subnet used shall be avaliable
$subnetDeployTmp = "vm-vnet"
# vnet rg shall be avaliable and created before
$resourceGrVnetName = "testit-vnet2"
# get the vnet
$resourceVnet =  Get-AzVirtualNetwork -Name $vnet -ResourceGroupName $resourceGrVnetName
Write-Host $resourceVnet.Name
Write-Host $resourceVnet.Location
$resourceSubnet = $resourceVnet.Subnets
$resourceSubnet | Format-Table -Property Name, AddressPrefix