# Network Watchers `[Microsoft.Network/networkWatchers]`

This module deploys a Network Watcher.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/locks` | [2020-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks) |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.Network/networkWatchers` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-04-01/networkWatchers) |
| `Microsoft.Network/networkWatchers/connectionMonitors` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-04-01/networkWatchers/connectionMonitors) |
| `Microsoft.Network/networkWatchers/flowLogs` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-04-01/networkWatchers/flowLogs) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br:bicep/modules/network.network-watcher:1.0.0`.

- [Using only defaults](#example-1-using-only-defaults)
- [Using large parameter set](#example-2-using-large-parameter-set)
- [WAF-aligned](#example-3-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module networkWatcher 'br:bicep/modules/network.network-watcher:1.0.0' = {
  name: '${uniqueString(deployment().name, testLocation)}-test-nnwmin'
  params: {
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    location: '<location>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "location": {
      "value": "<location>"
    }
  }
}
```

</details>
<p>

### Example 2: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module networkWatcher 'br:bicep/modules/network.network-watcher:1.0.0' = {
  name: '${uniqueString(deployment().name, testLocation)}-test-nnwmax'
  params: {
    connectionMonitors: [
      {
        endpoints: [
          {
            name: '<name>'
            resourceId: '<resourceId>'
            type: 'AzureVM'
          }
          {
            address: 'www.bing.com'
            name: 'Bing'
            type: 'ExternalAddress'
          }
        ]
        name: 'nnwmax-cm-001'
        testConfigurations: [
          {
            httpConfiguration: {
              method: 'Get'
              port: 80
              preferHTTPS: false
              requestHeaders: []
              validStatusCodeRanges: [
                '200'
              ]
            }
            name: 'HTTP Bing Test'
            protocol: 'Http'
            successThreshold: {
              checksFailedPercent: 5
              roundTripTimeMs: 100
            }
            testFrequencySec: 30
          }
        ]
        testGroups: [
          {
            destinations: [
              'Bing'
            ]
            disable: false
            name: 'test-http-Bing'
            sources: [
              'subnet-001(${resourceGroup.name})'
            ]
            testConfigurations: [
              'HTTP Bing Test'
            ]
          }
        ]
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    flowLogs: [
      {
        enabled: false
        storageId: '<storageId>'
        targetResourceId: '<targetResourceId>'
      }
      {
        formatVersion: 1
        name: 'nnwmax-fl-001'
        retentionInDays: 8
        storageId: '<storageId>'
        targetResourceId: '<targetResourceId>'
        trafficAnalyticsInterval: 10
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    location: '<location>'
    name: '<name>'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "connectionMonitors": {
      "value": [
        {
          "endpoints": [
            {
              "name": "<name>",
              "resourceId": "<resourceId>",
              "type": "AzureVM"
            },
            {
              "address": "www.bing.com",
              "name": "Bing",
              "type": "ExternalAddress"
            }
          ],
          "name": "nnwmax-cm-001",
          "testConfigurations": [
            {
              "httpConfiguration": {
                "method": "Get",
                "port": 80,
                "preferHTTPS": false,
                "requestHeaders": [],
                "validStatusCodeRanges": [
                  "200"
                ]
              },
              "name": "HTTP Bing Test",
              "protocol": "Http",
              "successThreshold": {
                "checksFailedPercent": 5,
                "roundTripTimeMs": 100
              },
              "testFrequencySec": 30
            }
          ],
          "testGroups": [
            {
              "destinations": [
                "Bing"
              ],
              "disable": false,
              "name": "test-http-Bing",
              "sources": [
                "subnet-001(${resourceGroup.name})"
              ],
              "testConfigurations": [
                "HTTP Bing Test"
              ]
            }
          ],
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "flowLogs": {
      "value": [
        {
          "enabled": false,
          "storageId": "<storageId>",
          "targetResourceId": "<targetResourceId>"
        },
        {
          "formatVersion": 1,
          "name": "nnwmax-fl-001",
          "retentionInDays": 8,
          "storageId": "<storageId>",
          "targetResourceId": "<targetResourceId>",
          "trafficAnalyticsInterval": 10,
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "name": {
      "value": "<name>"
    },
    "roleAssignments": {
      "value": [
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Reader"
        }
      ]
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>

### Example 3: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module networkWatcher 'br:bicep/modules/network.network-watcher:1.0.0' = {
  name: '${uniqueString(deployment().name, testLocation)}-test-nnwwaf'
  params: {
    connectionMonitors: [
      {
        endpoints: [
          {
            name: '<name>'
            resourceId: '<resourceId>'
            type: 'AzureVM'
          }
          {
            address: 'www.bing.com'
            name: 'Bing'
            type: 'ExternalAddress'
          }
        ]
        name: 'nnwwaf-cm-001'
        testConfigurations: [
          {
            httpConfiguration: {
              method: 'Get'
              port: 80
              preferHTTPS: false
              requestHeaders: []
              validStatusCodeRanges: [
                '200'
              ]
            }
            name: 'HTTP Bing Test'
            protocol: 'Http'
            successThreshold: {
              checksFailedPercent: 5
              roundTripTimeMs: 100
            }
            testFrequencySec: 30
          }
        ]
        testGroups: [
          {
            destinations: [
              'Bing'
            ]
            disable: false
            name: 'test-http-Bing'
            sources: [
              'subnet-001(${resourceGroup.name})'
            ]
            testConfigurations: [
              'HTTP Bing Test'
            ]
          }
        ]
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    flowLogs: [
      {
        enabled: false
        storageId: '<storageId>'
        targetResourceId: '<targetResourceId>'
      }
      {
        formatVersion: 1
        name: 'nnwwaf-fl-001'
        retentionInDays: 8
        storageId: '<storageId>'
        targetResourceId: '<targetResourceId>'
        trafficAnalyticsInterval: 10
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    location: '<location>'
    name: '<name>'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "connectionMonitors": {
      "value": [
        {
          "endpoints": [
            {
              "name": "<name>",
              "resourceId": "<resourceId>",
              "type": "AzureVM"
            },
            {
              "address": "www.bing.com",
              "name": "Bing",
              "type": "ExternalAddress"
            }
          ],
          "name": "nnwwaf-cm-001",
          "testConfigurations": [
            {
              "httpConfiguration": {
                "method": "Get",
                "port": 80,
                "preferHTTPS": false,
                "requestHeaders": [],
                "validStatusCodeRanges": [
                  "200"
                ]
              },
              "name": "HTTP Bing Test",
              "protocol": "Http",
              "successThreshold": {
                "checksFailedPercent": 5,
                "roundTripTimeMs": 100
              },
              "testFrequencySec": 30
            }
          ],
          "testGroups": [
            {
              "destinations": [
                "Bing"
              ],
              "disable": false,
              "name": "test-http-Bing",
              "sources": [
                "subnet-001(${resourceGroup.name})"
              ],
              "testConfigurations": [
                "HTTP Bing Test"
              ]
            }
          ],
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "flowLogs": {
      "value": [
        {
          "enabled": false,
          "storageId": "<storageId>",
          "targetResourceId": "<targetResourceId>"
        },
        {
          "formatVersion": 1,
          "name": "nnwwaf-fl-001",
          "retentionInDays": 8,
          "storageId": "<storageId>",
          "targetResourceId": "<targetResourceId>",
          "trafficAnalyticsInterval": 10,
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "name": {
      "value": "<name>"
    },
    "roleAssignments": {
      "value": [
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Reader"
        }
      ]
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>


## Parameters

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`connectionMonitors`](#parameter-connectionmonitors) | array | Array that contains the Connection Monitors. |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable telemetry via a Globally Unique Identifier (GUID). |
| [`flowLogs`](#parameter-flowlogs) | array | Array that contains the Flow Logs. |
| [`location`](#parameter-location) | string | Location for all resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`name`](#parameter-name) | string | Name of the Network Watcher resource (hidden). |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |

### Parameter: `connectionMonitors`

Array that contains the Connection Monitors.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `enableDefaultTelemetry`

Enable telemetry via a Globally Unique Identifier (GUID).
- Required: No
- Type: bool
- Default: `True`

### Parameter: `flowLogs`

Array that contains the Flow Logs.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `location`

Location for all resources.
- Required: No
- Type: string
- Default: `[resourceGroup().location]`

### Parameter: `lock`

The lock settings of the service.
- Required: No
- Type: object


| Name | Required | Type | Description |
| :-- | :-- | :--| :-- |
| [`kind`](#parameter-lockkind) | No | string | Optional. Specify the type of lock. |
| [`name`](#parameter-lockname) | No | string | Optional. Specify the name of lock. |

### Parameter: `lock.kind`

Optional. Specify the type of lock.

- Required: No
- Type: string
- Allowed: `[CanNotDelete, None, ReadOnly]`

### Parameter: `lock.name`

Optional. Specify the name of lock.

- Required: No
- Type: string

### Parameter: `name`

Name of the Network Watcher resource (hidden).
- Required: No
- Type: string
- Default: `[format('NetworkWatcher_{0}', parameters('location'))]`

### Parameter: `roleAssignments`

Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
- Required: No
- Type: array


| Name | Required | Type | Description |
| :-- | :-- | :--| :-- |
| [`condition`](#parameter-roleassignmentscondition) | No | string | Optional. The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container" |
| [`conditionVersion`](#parameter-roleassignmentsconditionversion) | No | string | Optional. Version of the condition. |
| [`delegatedManagedIdentityResourceId`](#parameter-roleassignmentsdelegatedmanagedidentityresourceid) | No | string | Optional. The Resource Id of the delegated managed identity resource. |
| [`description`](#parameter-roleassignmentsdescription) | No | string | Optional. The description of the role assignment. |
| [`principalId`](#parameter-roleassignmentsprincipalid) | Yes | string | Required. The principal ID of the principal (user/group/identity) to assign the role to. |
| [`principalType`](#parameter-roleassignmentsprincipaltype) | No | string | Optional. The principal type of the assigned principal ID. |
| [`roleDefinitionIdOrName`](#parameter-roleassignmentsroledefinitionidorname) | Yes | string | Required. The name of the role to assign. If it cannot be found you can specify the role definition ID instead. |

### Parameter: `roleAssignments.condition`

Optional. The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container"

- Required: No
- Type: string

### Parameter: `roleAssignments.conditionVersion`

Optional. Version of the condition.

- Required: No
- Type: string
- Allowed: `[2.0]`

### Parameter: `roleAssignments.delegatedManagedIdentityResourceId`

Optional. The Resource Id of the delegated managed identity resource.

- Required: No
- Type: string

### Parameter: `roleAssignments.description`

Optional. The description of the role assignment.

- Required: No
- Type: string

### Parameter: `roleAssignments.principalId`

Required. The principal ID of the principal (user/group/identity) to assign the role to.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.principalType`

Optional. The principal type of the assigned principal ID.

- Required: No
- Type: string
- Allowed: `[Device, ForeignGroup, Group, ServicePrincipal, User]`

### Parameter: `roleAssignments.roleDefinitionIdOrName`

Required. The name of the role to assign. If it cannot be found you can specify the role definition ID instead.

- Required: Yes
- Type: string

### Parameter: `tags`

Tags of the resource.
- Required: No
- Type: object


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the deployed network watcher. |
| `resourceGroupName` | string | The resource group the network watcher was deployed into. |
| `resourceId` | string | The resource ID of the deployed network watcher. |

## Cross-referenced modules

_None_
