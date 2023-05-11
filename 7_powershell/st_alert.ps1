$rv = Test-NetConnection -ComputerName staccountname.file.core.windows.net -Port 445
# Can access all ffileds from cmd
Write-Host $rv.TcpTestSucceeded

# Resolves to True or False


$stacc = "staaccname.file.core.windows.net"
$rv = Test-NetConnection -ComputerName $stacc -Port 445 | select TcpTestSucceeded
# status
Start-Process -NoNewWindow -FilePath "C:\OP\Zabbix Agent 6 arc\zabbix_agent-6.0.0-windows-amd64-openssl\bin\zabbix_sender.exe" -ArgumentList "-z ip -p 10051 -s server -k staccount -o $rv"

$da = Get-Date

Add-Content "C:\OP\Zabbix Agent 6 arc\Ims_oc_logger.txt" "$da Run done"


# https://blog.netwrix.com/2018/07/03/how-to-automate-powershell-scripts-with-task-scheduler/

# To schedule the PowerShell script, specify the following parameters:
# Action: Start a program
# Program\script: powershell
# Add arguments (optional): -File [Specify the file path to the script here]

# Powershell
# -File "C:\OP\Zabbix Agent 6 arc\Ims_oc_monitor-st-account.ps1"