param location string = resourceGroup().location

resource availabilitySet 'Microsoft.Compute/availabilitySets@2020-12-01' = {
  name: 'myAvailSet'
  location: location
  properties: {

  }
}
