param location string = resourceGroup().location

resource myVnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'myVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'mySubnet1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'mySubnet2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]

  }
}
