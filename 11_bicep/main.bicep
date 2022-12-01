
param location string = 'West Europe'
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'testbicepstaccount'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
