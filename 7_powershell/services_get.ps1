# get all automatic with name like
Get-Service | Select-Object -Property Name,DisplayName,Status,StartType | Where-Object { $_.StartType -eq "Automatic" -and ($_.Name -like "Aspen*" -or $_.Name -like "Afw*" -or $_.Name -like "Rabbit*" -or $_.Name -like "Goodtech*" -or $_.Name -like "W3SVC*" -or $_.Name -like "Tomcat*")}


