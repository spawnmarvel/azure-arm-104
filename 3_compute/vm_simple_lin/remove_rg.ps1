$resourceGr = "testit2-rg"

Get-AzResourceGroup -Name $resourceGr

$str =  Get-Date
Write-Host "List resources " $str " in " $resourceGr

$group = Get-AzResource -ResourceGroupName $resourceGr

foreach ($g in $group) {
    Write-Host $g.Name + " " $g.Sku.Name
    
}
# Delete all resources and the group, this takes some time, run it again to check the status or look in the portal
Get-AzResourceGroup -Name $resourceGr | Remove-AzResourceGroup -Force -AsJob