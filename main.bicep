param location string = resourceGroup().location
param subnetPrefix string = 'subnet'

resource myNIC 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'myNIC'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: '10.0.0.10'
          subnet: {
            id: myVNet.properties.subnets[0].id

          }
        }

      }
    ]
    networkSecurityGroup: {
      id: myNSG.id
    }
  }
}

resource myVNet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'myVNet'
  location: location
  properties: {

    subnets: [
      {
        name: '${subnetPrefix}-01'
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: myNSG.id
          }
        }
      }
      {
        name: '${subnetPrefix}-02'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }

    ]
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource myNSG 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: 'myNSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'rule1'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: 100
          protocol: 'Icmp'
          destinationAddressPrefix: '10.0.0.0/24'
          sourceAddressPrefixes: [
            '123.123.123.0/24'
            '10.0.0.1/24'
          ]
          sourcePortRange: '*'
          destinationPortRanges: [
            '80'
            '443'
          ]
        }
      }
    ]
  }
  tags: {
    tag1: 'MyNSG'
  }
}

output myOutput string = 'Deployed to region ${location}'
