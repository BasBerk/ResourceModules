# Logic Apps (Workflows) `[Microsoft.Logic/workflows]`

This module deploys a Logic App (Workflow).

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Notes](#Notes)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/locks` | [2020-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks) |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.Insights/diagnosticSettings` | [2021-05-01-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Insights/2021-05-01-preview/diagnosticSettings) |
| `Microsoft.Logic/workflows` | [2019-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Logic/2019-05-01/workflows) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br:bicep/modules/logic.workflow:1.0.0`.

- [Using large parameter set](#example-1-using-large-parameter-set)
- [WAF-aligned](#example-2-waf-aligned)

### Example 1: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module workflow 'br:bicep/modules/logic.workflow:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-lwmax'
  params: {
    // Required parameters
    name: 'lwmax001'
    // Non-required parameters
    diagnosticSettings: [
      {
        eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
        eventHubName: '<eventHubName>'
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        name: 'customSetting'
        storageAccountResourceId: '<storageAccountResourceId>'
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedIdentities: {
      userAssignedResourcesIds: [
        '<managedIdentityResourceId>'
      ]
    }
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
    workflowActions: {
      HTTP: {
        inputs: {
          body: {
            BeginPeakTime: '<BeginPeakTime>'
            EndPeakTime: '<EndPeakTime>'
            HostPoolName: '<HostPoolName>'
            LAWorkspaceName: '<LAWorkspaceName>'
            LimitSecondsToForceLogOffUser: '<LimitSecondsToForceLogOffUser>'
            LogOffMessageBody: '<LogOffMessageBody>'
            LogOffMessageTitle: '<LogOffMessageTitle>'
            MinimumNumberOfRDSH: 1
            ResourceGroupName: '<ResourceGroupName>'
            SessionThresholdPerCPU: 1
            UtcOffset: '<UtcOffset>'
          }
          method: 'POST'
          uri: 'https://testStringForValidation.com'
        }
        type: 'Http'
      }
    }
    workflowTriggers: {
      Recurrence: {
        recurrence: {
          frequency: 'Minute'
          interval: 15
        }
        type: 'Recurrence'
      }
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
    // Required parameters
    "name": {
      "value": "lwmax001"
    },
    // Non-required parameters
    "diagnosticSettings": {
      "value": [
        {
          "eventHubAuthorizationRuleResourceId": "<eventHubAuthorizationRuleResourceId>",
          "eventHubName": "<eventHubName>",
          "metricCategories": [
            {
              "category": "AllMetrics"
            }
          ],
          "name": "customSetting",
          "storageAccountResourceId": "<storageAccountResourceId>",
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "managedIdentities": {
      "value": {
        "userAssignedResourcesIds": [
          "<managedIdentityResourceId>"
        ]
      }
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
    },
    "workflowActions": {
      "value": {
        "HTTP": {
          "inputs": {
            "body": {
              "BeginPeakTime": "<BeginPeakTime>",
              "EndPeakTime": "<EndPeakTime>",
              "HostPoolName": "<HostPoolName>",
              "LAWorkspaceName": "<LAWorkspaceName>",
              "LimitSecondsToForceLogOffUser": "<LimitSecondsToForceLogOffUser>",
              "LogOffMessageBody": "<LogOffMessageBody>",
              "LogOffMessageTitle": "<LogOffMessageTitle>",
              "MinimumNumberOfRDSH": 1,
              "ResourceGroupName": "<ResourceGroupName>",
              "SessionThresholdPerCPU": 1,
              "UtcOffset": "<UtcOffset>"
            },
            "method": "POST",
            "uri": "https://testStringForValidation.com"
          },
          "type": "Http"
        }
      }
    },
    "workflowTriggers": {
      "value": {
        "Recurrence": {
          "recurrence": {
            "frequency": "Minute",
            "interval": 15
          },
          "type": "Recurrence"
        }
      }
    }
  }
}
```

</details>
<p>

### Example 2: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module workflow 'br:bicep/modules/logic.workflow:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-lwwaf'
  params: {
    // Required parameters
    name: 'lwwaf001'
    // Non-required parameters
    diagnosticSettings: [
      {
        eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
        eventHubName: '<eventHubName>'
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        name: 'customSetting'
        storageAccountResourceId: '<storageAccountResourceId>'
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedIdentities: {
      userAssignedResourcesIds: [
        '<managedIdentityResourceId>'
      ]
    }
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
    workflowActions: {
      HTTP: {
        inputs: {
          body: {
            BeginPeakTime: '<BeginPeakTime>'
            EndPeakTime: '<EndPeakTime>'
            HostPoolName: '<HostPoolName>'
            LAWorkspaceName: '<LAWorkspaceName>'
            LimitSecondsToForceLogOffUser: '<LimitSecondsToForceLogOffUser>'
            LogOffMessageBody: '<LogOffMessageBody>'
            LogOffMessageTitle: '<LogOffMessageTitle>'
            MinimumNumberOfRDSH: 1
            ResourceGroupName: '<ResourceGroupName>'
            SessionThresholdPerCPU: 1
            UtcOffset: '<UtcOffset>'
          }
          method: 'POST'
          uri: 'https://testStringForValidation.com'
        }
        type: 'Http'
      }
    }
    workflowTriggers: {
      Recurrence: {
        recurrence: {
          frequency: 'Minute'
          interval: 15
        }
        type: 'Recurrence'
      }
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
    // Required parameters
    "name": {
      "value": "lwwaf001"
    },
    // Non-required parameters
    "diagnosticSettings": {
      "value": [
        {
          "eventHubAuthorizationRuleResourceId": "<eventHubAuthorizationRuleResourceId>",
          "eventHubName": "<eventHubName>",
          "metricCategories": [
            {
              "category": "AllMetrics"
            }
          ],
          "name": "customSetting",
          "storageAccountResourceId": "<storageAccountResourceId>",
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "managedIdentities": {
      "value": {
        "userAssignedResourcesIds": [
          "<managedIdentityResourceId>"
        ]
      }
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
    },
    "workflowActions": {
      "value": {
        "HTTP": {
          "inputs": {
            "body": {
              "BeginPeakTime": "<BeginPeakTime>",
              "EndPeakTime": "<EndPeakTime>",
              "HostPoolName": "<HostPoolName>",
              "LAWorkspaceName": "<LAWorkspaceName>",
              "LimitSecondsToForceLogOffUser": "<LimitSecondsToForceLogOffUser>",
              "LogOffMessageBody": "<LogOffMessageBody>",
              "LogOffMessageTitle": "<LogOffMessageTitle>",
              "MinimumNumberOfRDSH": 1,
              "ResourceGroupName": "<ResourceGroupName>",
              "SessionThresholdPerCPU": 1,
              "UtcOffset": "<UtcOffset>"
            },
            "method": "POST",
            "uri": "https://testStringForValidation.com"
          },
          "type": "Http"
        }
      }
    },
    "workflowTriggers": {
      "value": {
        "Recurrence": {
          "recurrence": {
            "frequency": "Minute",
            "interval": 15
          },
          "type": "Recurrence"
        }
      }
    }
  }
}
```

</details>
<p>


## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | The logic app workflow name. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`actionsAccessControlConfiguration`](#parameter-actionsaccesscontrolconfiguration) | object | The access control configuration for workflow actions. |
| [`connectorEndpointsConfiguration`](#parameter-connectorendpointsconfiguration) | object | The endpoints configuration:  Access endpoint and outgoing IP addresses for the connector. |
| [`contentsAccessControlConfiguration`](#parameter-contentsaccesscontrolconfiguration) | object | The access control configuration for accessing workflow run contents. |
| [`definitionParameters`](#parameter-definitionparameters) | object | Parameters for the definition template. |
| [`diagnosticSettings`](#parameter-diagnosticsettings) | array | The diagnostic settings of the service. |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable telemetry via a Globally Unique Identifier (GUID). |
| [`integrationAccount`](#parameter-integrationaccount) | object | The integration account. |
| [`integrationServiceEnvironmentResourceId`](#parameter-integrationserviceenvironmentresourceid) | string | The integration service environment Id. |
| [`location`](#parameter-location) | string | Location for all resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`managedIdentities`](#parameter-managedidentities) | object | The managed identity definition for this resource. Only one type of identity is supported: system-assigned or user-assigned, but not both. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |
| [`state`](#parameter-state) | string | The state. - NotSpecified, Completed, Enabled, Disabled, Deleted, Suspended. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |
| [`triggersAccessControlConfiguration`](#parameter-triggersaccesscontrolconfiguration) | object | The access control configuration for invoking workflow triggers. |
| [`workflowActions`](#parameter-workflowactions) | object | The definitions for one or more actions to execute at workflow runtime. |
| [`workflowEndpointsConfiguration`](#parameter-workflowendpointsconfiguration) | object | The endpoints configuration:  Access endpoint and outgoing IP addresses for the workflow. |
| [`workflowManagementAccessControlConfiguration`](#parameter-workflowmanagementaccesscontrolconfiguration) | object | The access control configuration for workflow management. |
| [`workflowOutputs`](#parameter-workflowoutputs) | object | The definitions for the outputs to return from a workflow run. |
| [`workflowParameters`](#parameter-workflowparameters) | object | The definitions for one or more parameters that pass the values to use at your logic app's runtime. |
| [`workflowStaticResults`](#parameter-workflowstaticresults) | object | The definitions for one or more static results returned by actions as mock outputs when static results are enabled on those actions. In each action definition, the runtimeConfiguration.staticResult.name attribute references the corresponding definition inside staticResults. |
| [`workflowTriggers`](#parameter-workflowtriggers) | object | The definitions for one or more triggers that instantiate your workflow. You can define more than one trigger, but only with the Workflow Definition Language, not visually through the Logic Apps Designer. |

### Parameter: `actionsAccessControlConfiguration`

The access control configuration for workflow actions.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `connectorEndpointsConfiguration`

The endpoints configuration:  Access endpoint and outgoing IP addresses for the connector.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `contentsAccessControlConfiguration`

The access control configuration for accessing workflow run contents.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `definitionParameters`

Parameters for the definition template.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `diagnosticSettings`

The diagnostic settings of the service.
- Required: No
- Type: array


| Name | Required | Type | Description |
| :-- | :-- | :--| :-- |
| [`eventHubAuthorizationRuleResourceId`](#parameter-diagnosticsettingseventhubauthorizationruleresourceid) | No | string | Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to. |
| [`eventHubName`](#parameter-diagnosticsettingseventhubname) | No | string | Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`logAnalyticsDestinationType`](#parameter-diagnosticsettingsloganalyticsdestinationtype) | No | string | Optional. A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type. |
| [`logCategoriesAndGroups`](#parameter-diagnosticsettingslogcategoriesandgroups) | No | array | Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to '' to disable log collection. |
| [`marketplacePartnerResourceId`](#parameter-diagnosticsettingsmarketplacepartnerresourceid) | No | string | Optional. The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs. |
| [`metricCategories`](#parameter-diagnosticsettingsmetriccategories) | No | array | Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to '' to disable log collection. |
| [`name`](#parameter-diagnosticsettingsname) | No | string | Optional. The name of diagnostic setting. |
| [`storageAccountResourceId`](#parameter-diagnosticsettingsstorageaccountresourceid) | No | string | Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`workspaceResourceId`](#parameter-diagnosticsettingsworkspaceresourceid) | No | string | Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |

### Parameter: `diagnosticSettings.eventHubAuthorizationRuleResourceId`

Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.eventHubName`

Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logAnalyticsDestinationType`

Optional. A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.

- Required: No
- Type: string
- Allowed: `[AzureDiagnostics, Dedicated]`

### Parameter: `diagnosticSettings.logCategoriesAndGroups`

Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to '' to disable log collection.

- Required: No
- Type: array

| Name | Required | Type | Description |
| :-- | :-- | :--| :-- |
| [`category`](#parameter-diagnosticsettingslogcategoriesandgroupscategory) | No | string | Optional. Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here. |
| [`categoryGroup`](#parameter-diagnosticsettingslogcategoriesandgroupscategorygroup) | No | string | Optional. Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to 'AllLogs' to collect all logs. |

### Parameter: `diagnosticSettings.logCategoriesAndGroups.category`

Optional. Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logCategoriesAndGroups.categoryGroup`

Optional. Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to 'AllLogs' to collect all logs.

- Required: No
- Type: string


### Parameter: `diagnosticSettings.marketplacePartnerResourceId`

Optional. The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.metricCategories`

Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to '' to disable log collection.

- Required: No
- Type: array

| Name | Required | Type | Description |
| :-- | :-- | :--| :-- |
| [`category`](#parameter-diagnosticsettingsmetriccategoriescategory) | Yes | string | Required. Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to 'AllMetrics' to collect all metrics. |

### Parameter: `diagnosticSettings.metricCategories.category`

Required. Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to 'AllMetrics' to collect all metrics.

- Required: Yes
- Type: string


### Parameter: `diagnosticSettings.name`

Optional. The name of diagnostic setting.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.storageAccountResourceId`

Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.workspaceResourceId`

Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `enableDefaultTelemetry`

Enable telemetry via a Globally Unique Identifier (GUID).
- Required: No
- Type: bool
- Default: `True`

### Parameter: `integrationAccount`

The integration account.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `integrationServiceEnvironmentResourceId`

The integration service environment Id.
- Required: No
- Type: string
- Default: `''`

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

### Parameter: `managedIdentities`

The managed identity definition for this resource. Only one type of identity is supported: system-assigned or user-assigned, but not both.
- Required: No
- Type: object


| Name | Required | Type | Description |
| :-- | :-- | :--| :-- |
| [`systemAssigned`](#parameter-managedidentitiessystemassigned) | No | bool | Optional. Enables system assigned managed identity on the resource. |
| [`userAssignedResourcesIds`](#parameter-managedidentitiesuserassignedresourcesids) | No | array | Optional. The resource ID(s) to assign to the resource. |

### Parameter: `managedIdentities.systemAssigned`

Optional. Enables system assigned managed identity on the resource.

- Required: No
- Type: bool

### Parameter: `managedIdentities.userAssignedResourcesIds`

Optional. The resource ID(s) to assign to the resource.

- Required: No
- Type: array

### Parameter: `name`

The logic app workflow name.
- Required: Yes
- Type: string

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

### Parameter: `state`

The state. - NotSpecified, Completed, Enabled, Disabled, Deleted, Suspended.
- Required: No
- Type: string
- Default: `'Enabled'`
- Allowed:
  ```Bicep
  [
    'Completed'
    'Deleted'
    'Disabled'
    'Enabled'
    'NotSpecified'
    'Suspended'
  ]
  ```

### Parameter: `tags`

Tags of the resource.
- Required: No
- Type: object

### Parameter: `triggersAccessControlConfiguration`

The access control configuration for invoking workflow triggers.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `workflowActions`

The definitions for one or more actions to execute at workflow runtime.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `workflowEndpointsConfiguration`

The endpoints configuration:  Access endpoint and outgoing IP addresses for the workflow.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `workflowManagementAccessControlConfiguration`

The access control configuration for workflow management.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `workflowOutputs`

The definitions for the outputs to return from a workflow run.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `workflowParameters`

The definitions for one or more parameters that pass the values to use at your logic app's runtime.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `workflowStaticResults`

The definitions for one or more static results returned by actions as mock outputs when static results are enabled on those actions. In each action definition, the runtimeConfiguration.staticResult.name attribute references the corresponding definition inside staticResults.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `workflowTriggers`

The definitions for one or more triggers that instantiate your workflow. You can define more than one trigger, but only with the Workflow Definition Language, not visually through the Logic Apps Designer.
- Required: No
- Type: object
- Default: `{}`


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the logic app. |
| `resourceGroupName` | string | The resource group the logic app was deployed into. |
| `resourceId` | string | The resource ID of the logic app. |
| `systemAssignedMIPrincipalId` | string | The principal ID of the system assigned identity. |

## Cross-referenced modules

_None_

## Notes

### Parameter Usage `<accessControl>AccessControlConfiguration`

- `actionsAccessControlConfiguration`
- `contentsAccessControlConfiguration`
- `triggersAccessControlConfiguration`
- `workflowManagementAccessControlConfiguration`

<details>

<summary>Parameter JSON format</summary>

```json
"<accessControl>AccessControlConfiguration": {
    "value": {
        "allowedCallerIpAddresses": [
            {
                "addressRange": "string"
            }
        ],
        "openAuthenticationPolicies": {
            "policies": {}
        }
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
'<accessControl>AccessControlConfiguration': {
    allowedCallerIpAddresses: [
        {
            addressRange: 'string'
        }
    ]
    openAuthenticationPolicies: {
        policies: {}
    }
}
```

</details>
<p>

### Parameter Usage `<flow>EndpointsConfiguration`

- `connectorEndpointsConfiguration`
- `workflowEndpointsConfiguration`

<details>

<summary>Parameter JSON format</summary>

```json
"<flow>EndpointsConfiguration": {
    "value": {
        "outgoingIpAddresses": [
            {
                "address": "string"
            }
        ],
            "accessEndpointIpAddresses": [
            {
                "address": "string"
            }
        ]
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
'<flow>EndpointsConfiguration': {
    outgoingIpAddresses: [
        {
            address: 'string'
        }
    ]
    accessEndpointIpAddresses: [
        {
            address: 'string'
        }
    ]
}
```

</details>
<p>
