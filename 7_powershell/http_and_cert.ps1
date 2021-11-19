# RUN POWERSHELL AS ADMIN
$response = Invoke-WebRequest -URI https://follow-e-lo.com/
Write-Output $response.StatusCode

# 200

# check a certificate
[Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
$url = "https://follow-e-lo.com/"
$req = [Net.HttpWebRequest]::Create($url)
$req.GetResponse() | Out-Null
$output = [PSCustomObject]@{
   URL = $url
   'Cert Start Date' = $req.ServicePoint.Certificate.GetEffectiveDateString()
   'Cert End Date' = $req.ServicePoint.Certificate.GetExpirationDateString()
}
$output

# URL                      Cert Start Date     Cert End Date
# ---                      ---------------     -------------
# https://follow-e-lo.com/ 29.08.2021 13:32:00 27.11.2021 12:31:59