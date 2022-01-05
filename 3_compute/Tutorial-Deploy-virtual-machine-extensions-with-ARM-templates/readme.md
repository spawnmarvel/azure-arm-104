# Simple vm with username and password from script with vm extension ps1

If you have a rg and a vnet, here is how to make a vm and include it in the vnet with below mentioned SKU, settings and connect it to the vnet
(Make the vm type it in the portal first, stop at review + create and  download for automation.)

### 1 Resource group and vnet used: 
* testit2-rg 
* testit2-vnet

```ps1
$vnet = "testit2-vnet"
$rgName = "testit2-rg"
```
### 1.1  A note about vnet:

#### When you create or update a virtual network in your subscription, Network Watcher will be enabled automatically in your Virtual Network's region. There is no impact to your resources or associated charge for automatically enabling Network Watcher. 


### 2 The information provided in the Portal:

* Virtual machine name test-vm8081
* Availability zone, 1
* Windows Server 2019 Datacenter - Gen2
* Standard_BS2s - 2 vpcu, 4 gb memory A$48/mon ?
* Administrator account + password
* Public inbound ports, allow RDP, 3389
* Disk standard, StandardSSD_LRS
* Virtual net, testit2-vnet
* Subnet default, 10.0.0.0/24
* Public ip, (new) 
* Public inbound ports, allow RDP
* Boot diagnostics, Disable
* extensions is empty now, will add when template works

### 3 Download the template and parameter for automation, cp the template to vm_template, cp the parameters to vm_parameters
### 3.1 Changes in the template, most important is described in the 3.3 Ps1 section
### (3.2 ) If you do not not want to change anything as described in 3.1, just provide a rg, templatefile, paramterfile and New-AzResourceGroupDeployment with just the
### main parameters(rg, tempfile, paramfile and user + password):

### 3.3 Ps1:
```ps1
# From the template file you download you have a parameter virtual network id as:
"virtualNetworkId": {
            "type": "string"
        },
# From the parameter file you download you have the value for parameter virtual network id as:
"virtualNetworkId": {
            "value": "/subscriptions/an-id-xxxxxx-x-x-x-x-x-x-x-x/resourceGroups/testit2-rg/providers/Microsoft.Network/virtualNetworks/testit2-vnet"
            
        },
# We changed it to get it dynamically and keep it secure only to the session:
# From the parameter file you download where the value were stored, we change it to:
 "virtualNetworkId": {
            "value": null
            
        },
# And get it like this:
$sub = Get-AzSubscription
# [..]
# construct the virtualNetworkId (is has been removed from the downloaded parameter file used here) and it is ready to use
$vnetId = "/subscriptions/" + $sub.Id +  "/resourceGroups/" + $resourceGr.ResourceGroupName + "/providers/Microsoft.Network/virtualNetworks/" +$vnet

# The same goes for adminUserName from the parameter file, set it to null, we generate it from script
"adminUsername": {
            "value": null
        },
```

### 4 Run deploy_vm_simple.ps1 for testing with -WhatIf, change to -Verbose for actual deploy
```ps1
# template file
$templateFile = ".\vm_template.json"
# parameter file
# [...]
$paramterFile = ".\vm_paramters.json"
# [...]

New-AzResourceGroupDeployment -Name $deployName `
  -ResourceGroupName $resourceGr.ResourceGroupName `
  -virtualNetworkId $vnetId `
  -TemplateFile $templateFile -TemplateParameterFile $paramterFile -adminUsername $userName -adminPassword $passWordSecure -WhatIf
```

### 4.1 Secure the password if not using keyvault

```ps1
$var = Get-Content ".\keyvault.txt"
$arr = $var.Split([Environment]::NewLine)
Write-Host $arr
$userName = $arr[0]
$passWordSecure = ConvertTo-SecureString $arr[1] -AsPlainText -Force
Write-Host $userName
Write-Host $arr[1]
Write-Host $passWordSecure
```

### 5 Use mstsc to login (give it some minutes after deploy, due to virtual machine agent must be ready)
\Username

Test-NetConnection -ComputerName IP -Port 3389
* 
Reset password
But please use private IP in prod and make a separate public IP or other "DMZ" stuff

https://docs.microsoft.com/en-us/answers/questions/665787/virtual-machine-agent-status-not-ready.html

https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/windows-azure-guest-agent

You can run the following PowerShell command to check whether VM Agent has been deployed to the VM:

Get-AzVM -ResourceGroupName "RGNAME" -Name "VMNAME" -DisplayHint expand

In the output, locate the ProvisionVMAgent property, and check whether the value is set to True. If it is, this means that the agent is installed on the VM.

### 6 Scripts
Use the scripts:
* get_rg_resources
* deploy_vm # test with -WhatIf, deploy with -Verbose or -Debug
* remove_rg.ps1