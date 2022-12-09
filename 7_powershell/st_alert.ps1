$rv = Test-NetConnection -ComputerName staccountname.file.core.windows.net -Port 445
# can access all ffileds from cmd
Write-Host $rv.TcpTestSucceeded

Resolves to True or False
