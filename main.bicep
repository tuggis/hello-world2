param b bool = false
param s string = 'Hello'
param o object = { name: 'Per' }
param t string = (b == true) ? '${b} is true' : '${b} is false'
output o string = 'My output'

@allowed([ 'Prod' ])
param p string = 'Prod'
