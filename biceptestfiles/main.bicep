@description('Storage account for application data')
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'myoutdatedstorage'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

@description('Virtual network for application')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: 'myoutdatedvnet'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

@description('Virtual machine for application')
resource virtualMachine 'Microsoft.Compute/virtualMachines@2019-07-01' = {
  name: 'myoutdatedvm'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: 'myvm'
      adminUsername: 'azureuser'
      adminPassword: 'SecurePassword123!'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/myNIC'
        }
      ]
    }
  }
}
