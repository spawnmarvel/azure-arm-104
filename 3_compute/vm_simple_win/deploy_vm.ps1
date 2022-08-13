write-Host "1 Started: Simple vm with username and password from script and vnet in a different rg but same region" -ForegroundColor Green
Write-Host "2 Creating the rg for VM (it is automatically created if you have not done it) " -ForegroundColor Yellow
Write-Host "3 Vnet and subnet (you must create, if not this script will stop) before you start, the default value is -default for subnet, in no param is given" -ForegroundColor Yellow
Write-Host "4 customPrefixTmp = 'test-' + ran # substitute ran for 'test-123' to deploy to the same vm over and over again, to check updates on that vm with new template updates" -ForegroundColor Yellow
Write-Host "`n"
$ran = Get-Random -Maximum 1000
$deployName = "buildTestVm1" + $ran 
Write-Host "Running deploy: " $deployName
$customPrefixTmp = 'test-' + $ran # substitute ran for 'test-123' to deploy to the same vm over and over again, to check updates on that vm with new template updates
Write-Host "Custom prefix for VM, NSG, NIC, IP: " $customPrefixTmp
# connect to azure first
# Connect-AzAccount
$sub = Get-AzSubscription
# vnet used shall be avaliable 
#  **** VNET
Write-Host "Vnet info: "
$vnet = "vnet004799"
# subnet used shall be avaliable
$subnetDeployTmp = "vm-vnet"
# vnet rg shall be avaliable and created before
$resourceGrVnetName = "testit-vnet2"
Write-Host "Get VNET info: "
try {
  $tmp_resourceVnet = Get-AzVirtualNetwork -Name $vnet -ResourceGroupName $resourceGrVnetName
  Write-Host "VNET exists: " $tmp_resourceVnet.Name -ForegroundColor Green

}
catch {
  # $_
  Write-Host "The VNET does not exist " $rgName "Exit script" -ForegroundColor Red
  Return

}
# get the vnet
$resourceVnet = Get-AzVirtualNetwork -Name $vnet -ResourceGroupName $resourceGrVnetName
Write-Host $resourceVnet.Name -ForegroundColor Green
Write-Host $resourceVnet.Location
$resourceSubnet = $resourceVnet.Subnets
$resourceSubnet | Format-Table -Property Name, AddressPrefix
# **** VNET
# vm rg
$rgName = "testit2-rg"
# create rg
$resourceGrVM = New-AzResourceGroup -Name $rgName -Location "west europe" -Force
#  check that we have the vm resource group
Write-Host "Get resource group for VM deploy in : " $rgName
try {
  $tmp_resourceGrVM = Get-AzResource -ResourceGroupName $rgName
  Write-Host "RG for VM exists : " $rgName -ForegroundColor Green
}
catch {
  # $_
  Write-Host "The resource group does not exist " $rgName "Exit script" -ForegroundColor Red
  Return
  
}
Write-Host "Deploy VM : " $customPrefixTmp ": to rg : " $rgName
Write-Host "Connect VM : " $customPrefixTmp " to subnet: " $subnetDeployTmp " : in vnet : "  $vnet " : in vnet rg : " $resourceGrVnetName

Write-Host "Continue..." -ForegroundColor Green
# construct the virtualNetworkId from the vnet rg, not the vm rg (is has been removed from the downloaded paramter file)
# $vnetId = "/subscriptions/" + $sub.Id + "/resourceGroups/" + $resourceGrVnet.ResourceGroupName + "/providers/Microsoft.Network/virtualNetworks/" + $vnet
$vnetId = "/subscriptions/" + $sub.Id + "/resourceGroups/" + $resourceGrVnetName + "/providers/Microsoft.Network/virtualNetworks/" + $vnet
Write-Host $vnetId
# template file
$templateFile = ".\vm_template.json"
# parameter file
$paramterFile = ".\vm_parameters.json"

# jepp secure it, and get it from keyvault
$var = Get-Content ".\keyvault.txt"
$arr = $var.Split([Environment]::NewLine)
$userName = $arr[0]
$passWordSecure = ConvertTo-SecureString $arr[1] -AsPlainText -Force
Write-Host $userName
Write-Host $passWordSecure

# test it
New-AzResourceGroupDeployment -Name $deployName `
  -customPrefix $customPrefixTmp `
  -deployToSubnet $subnetDeployTmp `
  -ResourceGroupName $resourceGrVM.ResourceGroupName `
  -virtualNetworkId $vnetId `
  -TemplateFile $templateFile -TemplateParameterFile $paramterFile -adminUsername $userName -adminPassword $passWordSecure -Verbose
# verbose or debug for actually deploying it, wwhatif for test template

# Test success 16.01.2022 1, changed vnet id URL

