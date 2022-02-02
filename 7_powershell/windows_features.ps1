#install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
# GET
Get-WindowsFeature -Name "net*"

#Display Name                                            Name                       Install State
#------------                                            ----                       -------------
#[ ] Network Controller                                  NetworkController              Available
# [X] .NET Framework 3.5 Features                         NET-Framework-Features         Installed
# [...]
Remove-WindowsFeature -Name "NET-Framework-Features" -Verbose
# WAS needs .net 3.5
Get-WindowsFeature -Name "*WAS*"
Remove-WindowsFeature -Name "WAS-NET-Environment" -Verbose
# Check .Net
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name version -EA 0 | Where { $_.PSChildName -Match '^(?!S)\p{L}'} | Select PSChildName, version
 