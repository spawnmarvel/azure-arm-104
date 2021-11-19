Write-Host "Event ID 6005 will be labeled as “The event log service was started”. This means that a system boot session has been performed."
Write-Host "Event ID 6006 will be labeled as “The event log service was stopped”, corresponding to a system shutdown."
Write-Host "Event ID 1074: System has been shutdown by a process/user."
$env:computername
#Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime
Get-EventLog -LogName System -After $(Get-Date).AddMonths(-1) | Where { 6005, 6006, 1074 -contains $_.EventID}
