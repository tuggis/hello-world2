param location string = resourceGroup().location

module network 'network.bicep' = {
  name: 'myNetwork'
  params: {
    location: location
  }
}
module vms 'vm.bicep' = {
  name: 'myVMS'

}
output myOutput string = network.outputs.myVnetId
