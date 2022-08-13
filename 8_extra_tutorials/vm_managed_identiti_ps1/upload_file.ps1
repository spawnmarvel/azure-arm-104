
# Tutorial: Use a Windows VM system-assigned managed identity to access Azure Storage via a SAS credential
# https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-storage-sas

# 1 In the remote session and use Invoke-WebRequest to get an Azure Resource Manager token from the local managed identity for Azure resources endpoint. (The IP is Azure default IP))
$response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -Method GET -Headers @{Metadata="true"}

# 2 Next, extract the "Content" element, which is stored as a JavaScript Object Notation (JSON) formatted string in the $response object.
$content = $response.Content | ConvertFrom-Json

# 3 Next, extract the access token from the response.
$ArmToken = $content.access_token
Write-Host $ArmToken

# 4 Now use PowerShell to call Resource Manager using the access token we retrieved in the previous section, to create a storage SAS credential. 
# Once we have the SAS credential, we can call storage operations.
# First, convert the parameters to JSON, then call the storage listServiceSas endpoint to create the SAS credential:
$params = @{canonicalizedResource="/blob/testit3straccount/testmaidentity";signedResource="c";signedPermission="rcw";signedProtocol="https";signedExpiry="2022-08-14T00:00:00Z"}
$jsonParams = $params | ConvertTo-Json
# Bearer token is used here
$sasResponse = Invoke-WebRequest -Uri https://management.azure.com/subscriptions/xxx-findit-under-subscriptions-or-use-ps1-to-get-it/resourceGroups/test-it3/providers/Microsoft.Storage/storageAccounts/testit3straccount/listServiceSas/?api-version=2017-06-01 -Method POST -Body $jsonParams -Headers @{Authorization="Bearer $ArmToken"}

# 5 Now we can extract the SAS credential from the response:
$sasContent = $sasResponse.Content | ConvertFrom-Json
$sasCred = $sasContent.serviceSasToken

# 6 create a new file
New-Item -Path . -Name "test1.txt" -ItemType "file" -Value "This is a text string 1."

# 7 Set context and upload the file
$ctx = New-AzStorageContext -StorageAccountName testit3straccount -SasToken $sasCred
Set-AzStorageBlobContent -File test.txt -Container testmaidentity -Blob testblob1.txt -Context $ctx
# Get-AzStorageBlobContent -Container "testmaidentity" -Blob "helloworld.xt" -Destination "C:\test\" -Context $ctx