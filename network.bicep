param location string = resourceGroup().location

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
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
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'

        }
      }
      {
        name: 'Subnet-2'

        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'myNIC'
  location: location
  properties: {

    ipConfigurations: [
      {

        name: 'name'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetwork.properties.subnets[0].id
          }
          applicationSecurityGroups: [
            {
              id: applicationSecurityGroup.id
            }
          ]
        }
      }
    ]
  }
}
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: 'myNSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'nsgRule'
        properties: {
          description: 'description'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }

      }
      {
        name: 'nsgRule2'
        properties: {
          description: 'description2'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '10.0.0.4'
          access: 'Allow'
          priority: 101
          direction: 'Inbound'
        }
      }
    ]

  }

}

resource applicationSecurityGroup 'Microsoft.Network/applicationSecurityGroups@2020-11-01' = {
  name: 'myASG'
  location: location

}

output myVnetId string = virtualNetwork.id
