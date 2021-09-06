Get-WindowsFeature -Name "net*"

#Display Name                                            Name                       Install State
#------------                                            ----                       -------------
#[ ] Network Controller                                  NetworkController              Available
# [X] .NET Framework 3.5 Features                         NET-Framework-Features         Installed
# [...]
Remove-WindowsFeature -Name "NET-Framework-Features" -Verbose

# was needs .net 3.5
Get-WindowsFeature -Name "*was*"
Remove-WindowsFeature -Name "WAS-NET-Environment" -Verbose
 