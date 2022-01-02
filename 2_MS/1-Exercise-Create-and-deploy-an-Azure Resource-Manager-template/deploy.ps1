$templateFile = "./azuredeploy.json"
$ran = Get-Random -Maximum 100
$deployName = "buildTest" + $ran + $ran
Write-Host "Running deploy: " $deployName
$deploymentName=$deployName
$rg = 'learn-af1fd9f8-de1d-4048-a20a-48904672560b'
New-AzResourceGroupDeployment -Name $deploymentName `
  -ResourceGroupName $rg `
  -TemplateFile $templateFile `
  -storageName "espenklei12" `
  -storageSKU "Standard_LRS" -Verbose