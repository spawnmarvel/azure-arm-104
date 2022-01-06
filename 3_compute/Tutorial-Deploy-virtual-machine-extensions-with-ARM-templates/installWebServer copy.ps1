
$GetTime = Get-Date
$Folder = "C:\jobs-arm"
if (Test-Path -Path $Folder) {
    # Write-host "Path exists"
} else {
    # Write-Host "Path doesn't exist. Creating it."
    mkdir -p C:\jobs-arm
}

$FilePresent = Test-Path -Path C:\jobs-arm\log.txt -PathType Leaf
if ($FilePresent -eq "True") {
    # Write-Host "File exists"
}
else {
    Write-Host "File doesn't exist. Creating it."
    # New-Item C:\jobs-arm\log.txt
}
$IIS = Get-WindowsOptionalFeature -Online -FeatureName “IIS-WebServer”
if ($IIS.State -eq "Disabled") { 
    # Write-Host "IIS-WebServer not installed"
    $rv = $GetTime.ToString() + ": IIS-WebServer not installed " + $GetTime 
    Add-Content -Path C:\jobs-arm\log.txt -Value $rv
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
}
else {
    # Write-Host "IIS-WebServer is install"
    $rv = $GetTime.ToString() + ": IIS-WebServer is installed "
    Add-Content -Path C:\jobs-arm\log.txt -Value $rv
}