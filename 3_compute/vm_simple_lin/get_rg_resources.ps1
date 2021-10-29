$str =  Get-Date
$resourceGr = "testit2-rg"
Write-Host "List resources " $str " in " $resourceGr

$group = Get-AzResource -ResourceGroupName $resourceGr

foreach ($g in $group) {
    Write-Host $g.Name + " " $g.Sku.Name
    
}