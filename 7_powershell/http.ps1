$respone = Invoke-WebRequest -URI https://follow-e-lo.com/
Write-Output $respone.StatusCode
