$rv = Test-NetConnection -ComputerName staccountname.file.core.windows.net -Port 445
# Can access all ffileds from cmd
Write-Host $rv.TcpTestSucceeded

# Resolves to True or False


$stacc = "staaccname.file.core.windows.net"
$rv = Test-NetConnection -ComputerName $stacc -Port 445 | select TcpTestSucceeded
# status
Start-Process -NoNewWindow -FilePath "C:\OP\Zabbix Agent 6 arc\zabbix_agent-6.0.0-windows-amd64-openssl\bin\zabbix_sender.exe" -ArgumentList "-z ip -p 10051 -s EWEQWAPA1PET01 -k Pings288weqassaa1p2 -o $rv"

$da = Get-Date

Add-Content "C:\OP\Zabbix Agent 6 arc\Ims_oc_logger.txt" "$da Run done"


