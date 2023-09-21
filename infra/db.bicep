
param name string
param location string = resourceGroup().location
param tags object = {}
param prefix string
// value is read-only in cosmos
var dbserverUser = 'citus'
@secure()
param dbserverPassword string
param dbserverDatabaseName string

module dbserver 'core/database/cosmos/cosmos-pg-adapter.bicep' = {
  name: name
  params: {
    name: '${prefix}-postgresql'
    location: location
    tags: tags
    postgresqlVersion: '15'
    administratorLogin: dbserverUser
    administratorLoginPassword: dbserverPassword
    databaseName: dbserverDatabaseName
    allowAzureIPsFirewall: true
    coordinatorServerEdition: 'BurstableMemoryOptimized'
    coordinatorStorageQuotainMb: 131072
    coordinatorVCores: 1
    nodeCount: 0
    nodeVCores: 4
  }
}

output dbserverDatabaseName string = dbserverDatabaseName
output dbserverUser string = dbserverUser
output dbserverDomainName string = dbserver.outputs.domainName
