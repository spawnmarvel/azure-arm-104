resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'testbicepstaccount'
  location: 'West Europe'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
