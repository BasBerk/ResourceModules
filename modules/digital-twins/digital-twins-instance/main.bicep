metadata name = 'Digital Twins Instances'
metadata description = 'This module deploys an Azure Digital Twins Instance.'
metadata owner = 'Azure/module-maintainers'

@description('Required. The name of the Digital Twin Instance.')
@minLength(3)
@maxLength(63)
param name string

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Resource tags.')
param tags object?

@description('Optional. The lock settings of the service.')
param lock lockType

@description('Optional. Enables system assigned managed identity on the resource.')
param systemAssignedIdentity bool = false

@description('Optional. The ID(s) to assign to the resource.')
param userAssignedIdentities object = {}

@description('Optional. Event Hub Endpoint.')
param eventHubEndpoint object = {}

@description('Optional. Event Grid Endpoint.')
param eventGridEndpoint object = {}

@description('Optional. Service Bus Endpoint.')
param serviceBusEndpoint object = {}

@description('Optional. Configuration details for private endpoints. For security reasons, it is recommended to use private endpoints whenever possible.')
param privateEndpoints privateEndpointType

@description('Optional. Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set.')
@allowed([
  ''
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = ''

@description('Optional. The diagnostic settings of the service.')
param diagnosticSettings diagnosticSettingType

@description('Optional. Enable telemetry via the Customer Usage Attribution ID (GUID).')
param enableDefaultTelemetry bool = true

@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalIds\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
param roleAssignments roleAssignmentType

var enableReferencedModulesTelemetry = false

var identityType = systemAssignedIdentity ? (!empty(userAssignedIdentities) ? 'SystemAssigned, UserAssigned' : 'SystemAssigned') : (!empty(userAssignedIdentities) ? 'UserAssigned' : 'None')

var identity = identityType != 'None' ? {
  type: identityType
  userAssignedIdentities: !empty(userAssignedIdentities) ? userAssignedIdentities : null
} : null

var builtInRoleNames = {
  'Azure Digital Twins Data Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'bcd981a7-7f74-457b-83e1-cceb9e632ffe')
  'Azure Digital Twins Data Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'd57506d4-4c8d-48b1-8587-93c323f6a5a3')
  Contributor: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  Owner: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  Reader: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  'Role Based Access Control Administrator (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f58310d9-a9f6-439a-9e8d-f62e7b41a168')
  'User Access Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9')
}

resource defaultTelemetry 'Microsoft.Resources/deployments@2021-04-01' = if (enableDefaultTelemetry) {
  name: 'pid-47ed15a6-730a-4827-bcb4-0fd963ffbd82-${uniqueString(deployment().name, location)}'
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}

resource digitalTwinsInstance 'Microsoft.DigitalTwins/digitalTwinsInstances@2023-01-31' = {
  name: name
  location: location
  identity: identity
  tags: tags
  properties: {
    publicNetworkAccess: !empty(publicNetworkAccess) ? any(publicNetworkAccess) : (!empty(privateEndpoints) ? 'Disabled' : 'Enabled')
  }
}

module digitalTwinsInstance_eventHubEndpoint 'endpoint--event-hub/main.bicep' = if (!empty(eventHubEndpoint)) {
  name: '${uniqueString(deployment().name, location)}-DigitalTwinsInstance-Endpoints-EventHub'
  params: {
    digitalTwinInstanceName: digitalTwinsInstance.name
    name: contains(eventHubEndpoint, 'name') ? eventHubEndpoint.name : 'EventHubEndpoint'
    authenticationType: contains(eventHubEndpoint, 'authenticationType') ? eventHubEndpoint.authenticationType : 'KeyBased'
    connectionStringPrimaryKey: contains(eventHubEndpoint, 'connectionStringPrimaryKey') ? eventHubEndpoint.connectionStringPrimaryKey : ''
    connectionStringSecondaryKey: contains(eventHubEndpoint, 'connectionStringSecondaryKey') ? eventHubEndpoint.connectionStringSecondaryKey : ''
    deadLetterSecret: contains(eventHubEndpoint, 'deadLetterSecret') ? eventHubEndpoint.deadLetterSecret : ''
    deadLetterUri: contains(eventHubEndpoint, 'deadLetterUri') ? eventHubEndpoint.deadLetterUri : ''
    endpointUri: contains(eventHubEndpoint, 'endpointUri') ? eventHubEndpoint.endpointUri : ''
    entityPath: contains(eventHubEndpoint, 'entityPath') ? eventHubEndpoint.entityPath : ''
    enableDefaultTelemetry: enableReferencedModulesTelemetry
    systemAssignedIdentity: contains(eventHubEndpoint, 'systemAssignedIdentity') ? eventHubEndpoint.systemAssignedIdentity : false
    userAssignedIdentity: contains(eventHubEndpoint, 'userAssignedIdentity') ? eventHubEndpoint.userAssignedIdentity : {}
  }
}

module digitalTwinsInstance_eventGridEndpoint 'endpoint--event-grid/main.bicep' = if (!empty(eventGridEndpoint)) {
  name: '${uniqueString(deployment().name, location)}-DigitalTwinsInstance-Endpoints-EventGrid'
  params: {
    digitalTwinInstanceName: digitalTwinsInstance.name
    name: contains(eventGridEndpoint, 'name') ? eventGridEndpoint.name : 'EventGridEndpoint'
    topicEndpoint: contains(eventGridEndpoint, 'topicEndpoint') ? eventGridEndpoint.topicEndpoint : ''
    deadLetterSecret: contains(eventGridEndpoint, 'deadLetterSecret') ? eventGridEndpoint.deadLetterSecret : ''
    deadLetterUri: contains(eventGridEndpoint, 'deadLetterUri') ? eventGridEndpoint.deadLetterUri : ''
    enableDefaultTelemetry: enableReferencedModulesTelemetry
    eventGridDomainResourceId: contains(eventGridEndpoint, 'eventGridDomainId') ? eventGridEndpoint.eventGridDomainId : ''
  }
}

module digitalTwinsInstance_serviceBusEndpoint 'endpoint--service-bus/main.bicep' = if (!empty(serviceBusEndpoint)) {
  name: '${uniqueString(deployment().name, location)}-DigitalTwinsInstance-Endpoints-ServiceBus'
  params: {
    digitalTwinInstanceName: digitalTwinsInstance.name
    name: contains(serviceBusEndpoint, 'name') ? serviceBusEndpoint.name : 'ServiceBusEndpoint'
    authenticationType: contains(serviceBusEndpoint, 'authenticationType') ? serviceBusEndpoint.authenticationType : ''
    deadLetterSecret: contains(serviceBusEndpoint, 'deadLetterSecret') ? serviceBusEndpoint.deadLetterSecret : ''
    deadLetterUri: contains(serviceBusEndpoint, 'deadLetterUri') ? serviceBusEndpoint.deadLetterUri : ''
    endpointUri: contains(serviceBusEndpoint, 'endpointUri') ? serviceBusEndpoint.endpointUri : ''
    entityPath: contains(serviceBusEndpoint, 'entityPath') ? serviceBusEndpoint.entityPath : ''
    primaryConnectionString: contains(serviceBusEndpoint, 'primaryConnectionString') ? serviceBusEndpoint.primaryConnectionString : ''
    secondaryConnectionString: contains(serviceBusEndpoint, 'secondaryConnectionString') ? serviceBusEndpoint.secondaryConnectionString : ''
    enableDefaultTelemetry: enableReferencedModulesTelemetry
    systemAssignedIdentity: contains(eventHubEndpoint, 'systemAssignedIdentity') ? eventHubEndpoint.systemAssignedIdentity : false
    userAssignedIdentity: contains(eventHubEndpoint, 'userAssignedIdentity') ? eventHubEndpoint.userAssignedIdentity : {}
  }
}

module digitalTwinsInstance_privateEndpoints '../../network/private-endpoint/main.bicep' = [for (privateEndpoint, index) in (privateEndpoints ?? []): {
  name: '${uniqueString(deployment().name, location)}-digitalTwinsInstance-PrivateEndpoint-${index}'
  params: {
    groupIds: [
      privateEndpoint.?service ?? 'API'
    ]
    name: privateEndpoint.?name ?? 'pep-${last(split(digitalTwinsInstance.id, '/'))}-${privateEndpoint.?service ?? 'API'}-${index}'
    serviceResourceId: digitalTwinsInstance.id
    subnetResourceId: privateEndpoint.subnetResourceId
    enableDefaultTelemetry: privateEndpoint.?enableDefaultTelemetry ?? enableReferencedModulesTelemetry
    location: privateEndpoint.?location ?? reference(split(privateEndpoint.subnetResourceId, '/subnets/')[0], '2020-06-01', 'Full').location
    lock: privateEndpoint.?lock ?? lock
    privateDnsZoneGroupName: privateEndpoint.?privateDnsZoneGroupName
    privateDnsZoneResourceIds: privateEndpoint.?privateDnsZoneResourceIds
    roleAssignments: privateEndpoint.?roleAssignments
    tags: privateEndpoint.?tags ?? tags
    manualPrivateLinkServiceConnections: privateEndpoint.?manualPrivateLinkServiceConnections
    customDnsConfigs: privateEndpoint.?customDnsConfigs
    ipConfigurations: privateEndpoint.?ipConfigurations
    applicationSecurityGroupResourceIds: privateEndpoint.?applicationSecurityGroupResourceIds
    customNetworkInterfaceName: privateEndpoint.?customNetworkInterfaceName
  }
}]

resource digitalTwinsInstance_lock 'Microsoft.Authorization/locks@2020-05-01' = if (!empty(lock ?? {}) && lock.?kind != 'None') {
  name: lock.?name ?? 'lock-${name}'
  properties: {
    level: lock.?kind ?? ''
    notes: lock.?kind == 'CanNotDelete' ? 'Cannot delete resource or child resources.' : 'Cannot delete or modify the resource or child resources.'
  }
  scope: digitalTwinsInstance
}

resource digitalTwinsInstance_diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [for (diagnosticSetting, index) in (diagnosticSettings ?? []): {
  name: diagnosticSetting.?name ?? '${name}-diagnosticSettings'
  properties: {
    storageAccountId: diagnosticSetting.?storageAccountResourceId
    workspaceId: diagnosticSetting.?workspaceResourceId
    eventHubAuthorizationRuleId: diagnosticSetting.?eventHubAuthorizationRuleResourceId
    eventHubName: diagnosticSetting.?eventHubName
    metrics: diagnosticSetting.?metricCategories ?? [
      {
        category: 'AllMetrics'
        timeGrain: null
        enabled: true
      }
    ]
    logs: diagnosticSetting.?logCategoriesAndGroups ?? [
      {
        categoryGroup: 'AllLogs'
        enabled: true
      }
    ]
    marketplacePartnerId: diagnosticSetting.?marketplacePartnerResourceId
    logAnalyticsDestinationType: diagnosticSetting.?logAnalyticsDestinationType
  }
  scope: digitalTwinsInstance
}]

resource digitalTwinsInstance_roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for (roleAssignment, index) in (roleAssignments ?? []): {
  name: guid(digitalTwinsInstance.id, roleAssignment.principalId, roleAssignment.roleDefinitionIdOrName)
  properties: {
    roleDefinitionId: contains(builtInRoleNames, roleAssignment.roleDefinitionIdOrName) ? builtInRoleNames[roleAssignment.roleDefinitionIdOrName] : roleAssignment.roleDefinitionIdOrName
    principalId: roleAssignment.principalId
    description: roleAssignment.?description
    principalType: roleAssignment.?principalType
    condition: roleAssignment.?condition
    conditionVersion: !empty(roleAssignment.?condition) ? (roleAssignment.?conditionVersion ?? '2.0') : null // Must only be set if condtion is set
    delegatedManagedIdentityResourceId: roleAssignment.?delegatedManagedIdentityResourceId
  }
  scope: digitalTwinsInstance
}]

@description('The resource ID of the Digital Twins Instance.')
output resourceId string = digitalTwinsInstance.id

@description('The name of the resource group the resource was created in.')
output resourceGroupName string = resourceGroup().name

@description('The name of the Digital Twins Instance.')
output name string = digitalTwinsInstance.name

@description('The hostname of the Digital Twins Instance.')
output hostname string = digitalTwinsInstance.properties.hostName

@description('The location the resource was deployed into.')
output location string = digitalTwinsInstance.location

// =============== //
//   Definitions   //
// =============== //

type lockType = {
  @description('Optional. Specify the name of lock.')
  name: string?

  @description('Optional. Specify the type of lock.')
  kind: ('CanNotDelete' | 'ReadOnly' | 'None')?
}?

type roleAssignmentType = {
  @description('Required. The name of the role to assign. If it cannot be found you can specify the role definition ID instead.')
  roleDefinitionIdOrName: string

  @description('Required. The principal ID of the principal (user/group/identity) to assign the role to.')
  principalId: string

  @description('Optional. The principal type of the assigned principal ID.')
  principalType: ('ServicePrincipal' | 'Group' | 'User' | 'ForeignGroup' | 'Device')?

  @description('Optional. The description of the role assignment.')
  description: string?

  @description('Optional. The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container"')
  condition: string?

  @description('Optional. Version of the condition.')
  conditionVersion: '2.0'?

  @description('Optional. The Resource Id of the delegated managed identity resource.')
  delegatedManagedIdentityResourceId: string?
}[]?

type privateEndpointType = {
  @description('Optional. The name of the private endpoint.')
  name: string?

  @description('Optional. The location to deploy the private endpoint to.')
  location: string?

  @description('Optional. The service (sub-) type to deploy the private endpoint for. For example "vault" or "blob".')
  service: string?

  @description('Required. Resource ID of the subnet where the endpoint needs to be created.')
  subnetResourceId: string

  @description('Optional. The name of the private DNS zone group to create if privateDnsZoneResourceIds were provided.')
  privateDnsZoneGroupName: string?

  @description('Optional. The private DNS zone groups to associate the private endpoint with. A DNS zone group can support up to 5 DNS zones.')
  privateDnsZoneResourceIds: string[]?

  @description('Optional. Custom DNS configurations.')
  customDnsConfigs: {
    @description('Required. Fqdn that resolves to private endpoint ip address.')
    fqdn: string?

    @description('Required. A list of private ip addresses of the private endpoint.')
    ipAddresses: string[]
  }[]?

  @description('Optional. A list of IP configurations of the private endpoint. This will be used to map to the First Party Service endpoints.')
  ipConfigurations: {
    @description('Required. The name of the resource that is unique within a resource group.')
    name: string

    @description('Required. Properties of private endpoint IP configurations.')
    properties: {
      @description('Required. The ID of a group obtained from the remote resource that this private endpoint should connect to.')
      groupId: string

      @description('Required. The member name of a group obtained from the remote resource that this private endpoint should connect to.')
      memberName: string

      @description('Required. A private ip address obtained from the private endpoint\'s subnet.')
      privateIPAddress: string
    }
  }[]?

  @description('Optional. Application security groups in which the private endpoint IP configuration is included.')
  applicationSecurityGroupResourceIds: string[]?

  @description('Optional. The custom name of the network interface attached to the private endpoint.')
  customNetworkInterfaceName: string?

  @description('Optional. Specify the type of lock.')
  lock: lockType

  @description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
  roleAssignments: roleAssignmentType

  @description('Optional. Tags to be applied on all resources/resource groups in this deployment.')
  tags: object?

  @description('Optional. Manual PrivateLink Service Connections.')
  manualPrivateLinkServiceConnections: array?

  @description('Optional. Enable/Disable usage telemetry for module.')
  enableTelemetry: bool?
}[]?

type diagnosticSettingType = {
  @description('Optional. The name of diagnostic setting.')
  name: string?

  @description('Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to \'\' to disable log collection.')
  logCategoriesAndGroups: {
    @description('Optional. Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here.')
    category: string?

    @description('Optional. Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to \'AllLogs\' to collect all logs.')
    categoryGroup: string?
  }[]?

  @description('Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to \'\' to disable log collection.')
  metricCategories: {
    @description('Required. Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to \'AllMetrics\' to collect all metrics.')
    category: string
  }[]?

  @description('Optional. A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.')
  logAnalyticsDestinationType: ('Dedicated' | 'AzureDiagnostics')?

  @description('Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  workspaceResourceId: string?

  @description('Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  storageAccountResourceId: string?

  @description('Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
  eventHubAuthorizationRuleResourceId: string?

  @description('Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  eventHubName: string?

  @description('Optional. The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.')
  marketplacePartnerResourceId: string?
}[]?
