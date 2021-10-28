$str =  Get-Date
$resourceGr = "testit-rg"
Write-Host "List resources " $str " in " $resourceGr

$resourceGr = "testit-rg"
$group = Get-AzResource -ResourceGroupName $resourceGr

foreach ($g in $group) {
    Write-Host $g.Name + " " $g.Sku.Name
    
}