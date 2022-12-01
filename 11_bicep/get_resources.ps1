$str = Get-Date
$resourceGr = "test-it4"
Write-Host "List resources " $str " in " $resourceGr

try {
    $group = Get-AzResource -ResourceGroupName $resourceGr -ErrorAction Stop

    foreach ($g in $group) {
        Write-Host $g.Name + " " $g.Sku.Name
    
    }

}
catch {
    $errorMsg = $_.Exeption.Message 
    Write-Host "Failed to get resources:"
    Write-Host $_.Exception.ItemName
}
