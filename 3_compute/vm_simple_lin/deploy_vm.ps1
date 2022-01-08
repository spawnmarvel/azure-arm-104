write-Host "Started deploy simple vm" -ForegroundColor Green
Write-Host "Create the rg (it is automatically created if you have not) and vnet (you must create) before you start" -ForegroundColor Yellow
Write-Host "Get it from subscription and feed it to virtualNetworkId if you need to keep it safe" -ForegroundColor Yellow
Write-Host "Must also use a random generator for -Name on deploy"
$ran = Get-Random -Maximum 1000
$deployName = "buildTestVm1" + $ran
Write-Host "Running deploy: " $deployName
$customPrefixTmp = 'test-1' + $ran
Write-Host "Custom prefix: " $customPrefixTmp
# connect to azure first
# Connect-AzAccount
$sub = Get-AzSubscription
# vnet used shall be avaliable and
$vnet = "vnet004799"
# vnet rg shall be avaliable and created before
$resourceGrVnet =  Get-AzResourceGroup -Name "testit-vnet2"
# vm rg
$rgName = "testit2-rg"
# create rg
$resourceGrVM = New-AzResourceGroup -Name $rgName -Location "west europe" -Force
#  check that we have the vm rg
Write-Host "Get resources in : " $rgName
try {
  $group = Get-AzResource -ResourceGroupName $resourceGrVM.ResourceGroupName

  foreach ($g in $group) {
    Write-Host $g.Name + " " $g.Sku.Name
  }
}
catch {
  # $_
  Write-Host "The resource group does not exist " $rgName "Exit script" -ForegroundColor Red
  Return
  
}
Write-Host "Continue..." -ForegroundColor Green
# construct the virtualNetworkId from the vnet rg, not the vm rg (is has been removed from the downloaded paramter file)
$vnetId = "/subscriptions/" + $sub.Id + "/resourceGroups/" + $resourceGrVnet.ResourceGroupName + "/providers/Microsoft.Network/virtualNetworks/" + $vnet
Write-Host $vnetId
# template file
$templateFile = ".\vm_template.json"
# parameter file
$paramterFile = ".\vm_parameters.json"

# jepp secure it, and get it from keyvault
$var = Get-Content ".\keyvault.txt"
$arr = $var.Split([Environment]::NewLine)
Write-Host $arr
$userName = $arr[0]
$passWordSecure = ConvertTo-SecureString $arr[1] -AsPlainText -Force
Write-Host $userName
Write-Host $arr[1]
Write-Host $passWordSecure

# test it
New-AzResourceGroupDeployment -Name $deployName `
  -customPrefix $customPrefixTmp `
  -ResourceGroupName $resourceGrVM.ResourceGroupName `
  -virtualNetworkId $vnetId `
  -TemplateFile $templateFile -TemplateParameterFile $paramterFile -adminUsername $userName -adminPassword $passWordSecure -Verbose
   # verbose or debug or WhatIf for actually deploying it


