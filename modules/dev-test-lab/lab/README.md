# DevTest Labs `[Microsoft.DevTestLab/labs]`

This module deploys a DevTest Lab.

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
| `Microsoft.DevTestLab/labs` | [2018-10-15-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/labs) |
| `Microsoft.DevTestLab/labs/artifactsources` | [2018-09-15](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/2018-09-15/labs/artifactsources) |
| `Microsoft.DevTestLab/labs/costs` | [2018-09-15](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/2018-09-15/labs/costs) |
| `Microsoft.DevTestLab/labs/notificationchannels` | [2018-09-15](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/2018-09-15/labs/notificationchannels) |
| `Microsoft.DevTestLab/labs/policysets/policies` | [2018-09-15](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/2018-09-15/labs/policysets/policies) |
| `Microsoft.DevTestLab/labs/schedules` | [2018-09-15](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/2018-09-15/labs/schedules) |
| `Microsoft.DevTestLab/labs/virtualnetworks` | [2018-09-15](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/2018-09-15/labs/virtualnetworks) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br:bicep/modules/dev-test-lab.lab:1.0.0`.

- [Using only defaults](#example-1-using-only-defaults)
- [Using large parameter set](#example-2-using-large-parameter-set)
- [WAF-aligned](#example-3-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module lab 'br:bicep/modules/dev-test-lab.lab:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-dtllmin'
  params: {
    // Required parameters
    name: 'dtllmin001'
    // Non-required parameters
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
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
      "value": "dtllmin001"
    },
    // Non-required parameters
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
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
module lab 'br:bicep/modules/dev-test-lab.lab:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-dtllmax'
  params: {
    // Required parameters
    name: 'dtllmax001'
    // Non-required parameters
    announcement: {
      enabled: 'Enabled'
      expirationDate: '2025-12-30T13:00:00Z'
      markdown: 'DevTest Lab announcement text. <br> New line. It also supports Markdown'
      title: 'DevTest announcement title'
    }
    artifactsources: [
      {
        branchRef: 'master'
        displayName: 'Public Artifact Repo'
        folderPath: '/Artifacts'
        name: 'Public Repo'
        sourceType: 'GitHub'
        status: 'Disabled'
        uri: 'https://github.com/Azure/azure-devtestlab.git'
      }
      {
        armTemplateFolderPath: '/Environments'
        branchRef: 'master'
        displayName: 'Public Environment Repo'
        name: 'Public Environment Repo'
        sourceType: 'GitHub'
        status: 'Disabled'
        uri: 'https://github.com/Azure/azure-devtestlab.git'
      }
    ]
    artifactsStorageAccount: '<artifactsStorageAccount>'
    browserConnect: 'Enabled'
    costs: {
      cycleType: 'CalendarMonth'
      status: 'Enabled'
      target: 450
      thresholdValue100DisplayOnChart: 'Enabled'
      thresholdValue100SendNotificationWhenExceeded: 'Enabled'
    }
    disableAutoUpgradeCseMinorVersion: true
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    encryptionDiskEncryptionSetId: '<encryptionDiskEncryptionSetId>'
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    environmentPermission: 'Contributor'
    extendedProperties: {
      RdpConnectionType: '7'
    }
    isolateLabResources: 'Enabled'
    labStorageType: 'Premium'
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedIdentities: {
      userAssignedResourcesIds: [
        '<managedIdentityResourceId>'
      ]
    }
    managementIdentitiesResourceIds: [
      '<managedIdentityResourceId>'
    ]
    notificationchannels: [
      {
        description: 'Integration configured for auto-shutdown'
        emailRecipient: 'mail@contosodtlmail.com'
        events: [
          {
            eventName: 'AutoShutdown'
          }
        ]
        name: 'autoShutdown'
        notificationLocale: 'en'
        webHookUrl: 'https://webhook.contosotest.com'
      }
      {
        events: [
          {
            eventName: 'Cost'
          }
        ]
        name: 'costThreshold'
        webHookUrl: 'https://webhook.contosotest.com'
      }
    ]
    policies: [
      {
        evaluatorType: 'MaxValuePolicy'
        factData: '<factData>'
        factName: 'UserOwnedLabVmCountInSubnet'
        name: '<name>'
        threshold: '1'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'UserOwnedLabVmCount'
        name: 'MaxVmsAllowedPerUser'
        threshold: '2'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'UserOwnedLabPremiumVmCount'
        name: 'MaxPremiumVmsAllowedPerUser'
        status: 'Disabled'
        threshold: '1'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'LabVmCount'
        name: 'MaxVmsAllowedPerLab'
        threshold: '3'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'LabPremiumVmCount'
        name: 'MaxPremiumVmsAllowedPerLab'
        threshold: '2'
      }
      {
        evaluatorType: 'AllowedValuesPolicy'
        factData: ''
        factName: 'LabVmSize'
        name: 'AllowedVmSizesInLab'
        status: 'Enabled'
        threshold: '<threshold>'
      }
      {
        evaluatorType: 'AllowedValuesPolicy'
        factName: 'ScheduleEditPermission'
        name: 'ScheduleEditPermission'
        threshold: '<threshold>'
      }
      {
        evaluatorType: 'AllowedValuesPolicy'
        factName: 'GalleryImage'
        name: 'GalleryImage'
        threshold: '<threshold>'
      }
      {
        description: 'Public Environment Policy'
        evaluatorType: 'AllowedValuesPolicy'
        factName: 'EnvironmentTemplate'
        name: 'EnvironmentTemplate'
        threshold: '<threshold>'
      }
    ]
    premiumDataDisks: 'Enabled'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
    ]
    schedules: [
      {
        dailyRecurrence: {
          time: '0000'
        }
        name: 'LabVmsShutdown'
        notificationSettingsStatus: 'Enabled'
        notificationSettingsTimeInMinutes: 30
        status: 'Enabled'
        taskType: 'LabVmsShutdownTask'
        timeZoneId: 'AUS Eastern Standard Time'
      }
      {
        name: 'LabVmAutoStart'
        status: 'Enabled'
        taskType: 'LabVmsStartupTask'
        timeZoneId: 'AUS Eastern Standard Time'
        weeklyRecurrence: {
          time: '0700'
          weekdays: [
            'Friday'
            'Monday'
            'Thursday'
            'Tuesday'
            'Wednesday'
          ]
        }
      }
    ]
    support: {
      enabled: 'Enabled'
      markdown: 'DevTest Lab support text. <br> New line. It also supports Markdown'
    }
    tags: {
      'hidden-title': 'This is visible in the resource name'
      labName: 'dtllmax001'
      resourceType: 'DevTest Lab'
    }
    virtualnetworks: [
      {
        allowedSubnets: [
          {
            allowPublicIp: 'Allow'
            labSubnetName: '<labSubnetName>'
            resourceId: '<resourceId>'
          }
        ]
        description: 'lab virtual network description'
        externalProviderResourceId: '<externalProviderResourceId>'
        name: '<name>'
        subnetOverrides: [
          {
            labSubnetName: '<labSubnetName>'
            resourceId: '<resourceId>'
            sharedPublicIpAddressConfiguration: {
              allowedPorts: [
                {
                  backendPort: 3389
                  transportProtocol: 'Tcp'
                }
                {
                  backendPort: 22
                  transportProtocol: 'Tcp'
                }
              ]
            }
            useInVmCreationPermission: 'Allow'
            usePublicIpAddressPermission: 'Allow'
          }
        ]
      }
    ]
    vmCreationResourceGroupId: '<vmCreationResourceGroupId>'
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
      "value": "dtllmax001"
    },
    // Non-required parameters
    "announcement": {
      "value": {
        "enabled": "Enabled",
        "expirationDate": "2025-12-30T13:00:00Z",
        "markdown": "DevTest Lab announcement text. <br> New line. It also supports Markdown",
        "title": "DevTest announcement title"
      }
    },
    "artifactsources": {
      "value": [
        {
          "branchRef": "master",
          "displayName": "Public Artifact Repo",
          "folderPath": "/Artifacts",
          "name": "Public Repo",
          "sourceType": "GitHub",
          "status": "Disabled",
          "uri": "https://github.com/Azure/azure-devtestlab.git"
        },
        {
          "armTemplateFolderPath": "/Environments",
          "branchRef": "master",
          "displayName": "Public Environment Repo",
          "name": "Public Environment Repo",
          "sourceType": "GitHub",
          "status": "Disabled",
          "uri": "https://github.com/Azure/azure-devtestlab.git"
        }
      ]
    },
    "artifactsStorageAccount": {
      "value": "<artifactsStorageAccount>"
    },
    "browserConnect": {
      "value": "Enabled"
    },
    "costs": {
      "value": {
        "cycleType": "CalendarMonth",
        "status": "Enabled",
        "target": 450,
        "thresholdValue100DisplayOnChart": "Enabled",
        "thresholdValue100SendNotificationWhenExceeded": "Enabled"
      }
    },
    "disableAutoUpgradeCseMinorVersion": {
      "value": true
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "encryptionDiskEncryptionSetId": {
      "value": "<encryptionDiskEncryptionSetId>"
    },
    "encryptionType": {
      "value": "EncryptionAtRestWithCustomerKey"
    },
    "environmentPermission": {
      "value": "Contributor"
    },
    "extendedProperties": {
      "value": {
        "RdpConnectionType": "7"
      }
    },
    "isolateLabResources": {
      "value": "Enabled"
    },
    "labStorageType": {
      "value": "Premium"
    },
    "location": {
      "value": "<location>"
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
    "managementIdentitiesResourceIds": {
      "value": [
        "<managedIdentityResourceId>"
      ]
    },
    "notificationchannels": {
      "value": [
        {
          "description": "Integration configured for auto-shutdown",
          "emailRecipient": "mail@contosodtlmail.com",
          "events": [
            {
              "eventName": "AutoShutdown"
            }
          ],
          "name": "autoShutdown",
          "notificationLocale": "en",
          "webHookUrl": "https://webhook.contosotest.com"
        },
        {
          "events": [
            {
              "eventName": "Cost"
            }
          ],
          "name": "costThreshold",
          "webHookUrl": "https://webhook.contosotest.com"
        }
      ]
    },
    "policies": {
      "value": [
        {
          "evaluatorType": "MaxValuePolicy",
          "factData": "<factData>",
          "factName": "UserOwnedLabVmCountInSubnet",
          "name": "<name>",
          "threshold": "1"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "UserOwnedLabVmCount",
          "name": "MaxVmsAllowedPerUser",
          "threshold": "2"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "UserOwnedLabPremiumVmCount",
          "name": "MaxPremiumVmsAllowedPerUser",
          "status": "Disabled",
          "threshold": "1"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "LabVmCount",
          "name": "MaxVmsAllowedPerLab",
          "threshold": "3"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "LabPremiumVmCount",
          "name": "MaxPremiumVmsAllowedPerLab",
          "threshold": "2"
        },
        {
          "evaluatorType": "AllowedValuesPolicy",
          "factData": "",
          "factName": "LabVmSize",
          "name": "AllowedVmSizesInLab",
          "status": "Enabled",
          "threshold": "<threshold>"
        },
        {
          "evaluatorType": "AllowedValuesPolicy",
          "factName": "ScheduleEditPermission",
          "name": "ScheduleEditPermission",
          "threshold": "<threshold>"
        },
        {
          "evaluatorType": "AllowedValuesPolicy",
          "factName": "GalleryImage",
          "name": "GalleryImage",
          "threshold": "<threshold>"
        },
        {
          "description": "Public Environment Policy",
          "evaluatorType": "AllowedValuesPolicy",
          "factName": "EnvironmentTemplate",
          "name": "EnvironmentTemplate",
          "threshold": "<threshold>"
        }
      ]
    },
    "premiumDataDisks": {
      "value": "Enabled"
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
    "schedules": {
      "value": [
        {
          "dailyRecurrence": {
            "time": "0000"
          },
          "name": "LabVmsShutdown",
          "notificationSettingsStatus": "Enabled",
          "notificationSettingsTimeInMinutes": 30,
          "status": "Enabled",
          "taskType": "LabVmsShutdownTask",
          "timeZoneId": "AUS Eastern Standard Time"
        },
        {
          "name": "LabVmAutoStart",
          "status": "Enabled",
          "taskType": "LabVmsStartupTask",
          "timeZoneId": "AUS Eastern Standard Time",
          "weeklyRecurrence": {
            "time": "0700",
            "weekdays": [
              "Friday",
              "Monday",
              "Thursday",
              "Tuesday",
              "Wednesday"
            ]
          }
        }
      ]
    },
    "support": {
      "value": {
        "enabled": "Enabled",
        "markdown": "DevTest Lab support text. <br> New line. It also supports Markdown"
      }
    },
    "tags": {
      "value": {
        "hidden-title": "This is visible in the resource name",
        "labName": "dtllmax001",
        "resourceType": "DevTest Lab"
      }
    },
    "virtualnetworks": {
      "value": [
        {
          "allowedSubnets": [
            {
              "allowPublicIp": "Allow",
              "labSubnetName": "<labSubnetName>",
              "resourceId": "<resourceId>"
            }
          ],
          "description": "lab virtual network description",
          "externalProviderResourceId": "<externalProviderResourceId>",
          "name": "<name>",
          "subnetOverrides": [
            {
              "labSubnetName": "<labSubnetName>",
              "resourceId": "<resourceId>",
              "sharedPublicIpAddressConfiguration": {
                "allowedPorts": [
                  {
                    "backendPort": 3389,
                    "transportProtocol": "Tcp"
                  },
                  {
                    "backendPort": 22,
                    "transportProtocol": "Tcp"
                  }
                ]
              },
              "useInVmCreationPermission": "Allow",
              "usePublicIpAddressPermission": "Allow"
            }
          ]
        }
      ]
    },
    "vmCreationResourceGroupId": {
      "value": "<vmCreationResourceGroupId>"
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
module lab 'br:bicep/modules/dev-test-lab.lab:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-dtllwaf'
  params: {
    // Required parameters
    name: 'dtllwaf001'
    // Non-required parameters
    announcement: {
      enabled: 'Enabled'
      expirationDate: '2025-12-30T13:00:00Z'
      markdown: 'DevTest Lab announcement text. <br> New line. It also supports Markdown'
      title: 'DevTest announcement title'
    }
    artifactsources: [
      {
        branchRef: 'master'
        displayName: 'Public Artifact Repo'
        folderPath: '/Artifacts'
        name: 'Public Repo'
        sourceType: 'GitHub'
        status: 'Disabled'
        uri: 'https://github.com/Azure/azure-devtestlab.git'
      }
      {
        armTemplateFolderPath: '/Environments'
        branchRef: 'master'
        displayName: 'Public Environment Repo'
        name: 'Public Environment Repo'
        sourceType: 'GitHub'
        status: 'Disabled'
        uri: 'https://github.com/Azure/azure-devtestlab.git'
      }
    ]
    artifactsStorageAccount: '<artifactsStorageAccount>'
    browserConnect: 'Enabled'
    costs: {
      cycleType: 'CalendarMonth'
      status: 'Enabled'
      target: 450
      thresholdValue100DisplayOnChart: 'Enabled'
      thresholdValue100SendNotificationWhenExceeded: 'Enabled'
    }
    disableAutoUpgradeCseMinorVersion: true
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    encryptionDiskEncryptionSetId: '<encryptionDiskEncryptionSetId>'
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    environmentPermission: 'Contributor'
    extendedProperties: {
      RdpConnectionType: '7'
    }
    isolateLabResources: 'Enabled'
    labStorageType: 'Premium'
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedIdentities: {
      userAssignedResourcesIds: [
        '<managedIdentityResourceId>'
      ]
    }
    managementIdentitiesResourceIds: [
      '<managedIdentityResourceId>'
    ]
    notificationchannels: [
      {
        description: 'Integration configured for auto-shutdown'
        emailRecipient: 'mail@contosodtlmail.com'
        events: [
          {
            eventName: 'AutoShutdown'
          }
        ]
        name: 'autoShutdown'
        notificationLocale: 'en'
        webHookUrl: 'https://webhook.contosotest.com'
      }
      {
        events: [
          {
            eventName: 'Cost'
          }
        ]
        name: 'costThreshold'
        webHookUrl: 'https://webhook.contosotest.com'
      }
    ]
    policies: [
      {
        evaluatorType: 'MaxValuePolicy'
        factData: '<factData>'
        factName: 'UserOwnedLabVmCountInSubnet'
        name: '<name>'
        threshold: '1'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'UserOwnedLabVmCount'
        name: 'MaxVmsAllowedPerUser'
        threshold: '2'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'UserOwnedLabPremiumVmCount'
        name: 'MaxPremiumVmsAllowedPerUser'
        status: 'Disabled'
        threshold: '1'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'LabVmCount'
        name: 'MaxVmsAllowedPerLab'
        threshold: '3'
      }
      {
        evaluatorType: 'MaxValuePolicy'
        factName: 'LabPremiumVmCount'
        name: 'MaxPremiumVmsAllowedPerLab'
        threshold: '2'
      }
      {
        evaluatorType: 'AllowedValuesPolicy'
        factData: ''
        factName: 'LabVmSize'
        name: 'AllowedVmSizesInLab'
        status: 'Enabled'
        threshold: '<threshold>'
      }
      {
        evaluatorType: 'AllowedValuesPolicy'
        factName: 'ScheduleEditPermission'
        name: 'ScheduleEditPermission'
        threshold: '<threshold>'
      }
      {
        evaluatorType: 'AllowedValuesPolicy'
        factName: 'GalleryImage'
        name: 'GalleryImage'
        threshold: '<threshold>'
      }
      {
        description: 'Public Environment Policy'
        evaluatorType: 'AllowedValuesPolicy'
        factName: 'EnvironmentTemplate'
        name: 'EnvironmentTemplate'
        threshold: '<threshold>'
      }
    ]
    premiumDataDisks: 'Enabled'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
    ]
    schedules: [
      {
        dailyRecurrence: {
          time: '0000'
        }
        name: 'LabVmsShutdown'
        notificationSettingsStatus: 'Enabled'
        notificationSettingsTimeInMinutes: 30
        status: 'Enabled'
        taskType: 'LabVmsShutdownTask'
        timeZoneId: 'AUS Eastern Standard Time'
      }
      {
        name: 'LabVmAutoStart'
        status: 'Enabled'
        taskType: 'LabVmsStartupTask'
        timeZoneId: 'AUS Eastern Standard Time'
        weeklyRecurrence: {
          time: '0700'
          weekdays: [
            'Friday'
            'Monday'
            'Thursday'
            'Tuesday'
            'Wednesday'
          ]
        }
      }
    ]
    support: {
      enabled: 'Enabled'
      markdown: 'DevTest Lab support text. <br> New line. It also supports Markdown'
    }
    tags: {
      'hidden-title': 'This is visible in the resource name'
      labName: 'dtllwaf001'
      resourceType: 'DevTest Lab'
    }
    virtualnetworks: [
      {
        allowedSubnets: [
          {
            allowPublicIp: 'Allow'
            labSubnetName: '<labSubnetName>'
            resourceId: '<resourceId>'
          }
        ]
        description: 'lab virtual network description'
        externalProviderResourceId: '<externalProviderResourceId>'
        name: '<name>'
        subnetOverrides: [
          {
            labSubnetName: '<labSubnetName>'
            resourceId: '<resourceId>'
            sharedPublicIpAddressConfiguration: {
              allowedPorts: [
                {
                  backendPort: 3389
                  transportProtocol: 'Tcp'
                }
                {
                  backendPort: 22
                  transportProtocol: 'Tcp'
                }
              ]
            }
            useInVmCreationPermission: 'Allow'
            usePublicIpAddressPermission: 'Allow'
          }
        ]
      }
    ]
    vmCreationResourceGroupId: '<vmCreationResourceGroupId>'
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
      "value": "dtllwaf001"
    },
    // Non-required parameters
    "announcement": {
      "value": {
        "enabled": "Enabled",
        "expirationDate": "2025-12-30T13:00:00Z",
        "markdown": "DevTest Lab announcement text. <br> New line. It also supports Markdown",
        "title": "DevTest announcement title"
      }
    },
    "artifactsources": {
      "value": [
        {
          "branchRef": "master",
          "displayName": "Public Artifact Repo",
          "folderPath": "/Artifacts",
          "name": "Public Repo",
          "sourceType": "GitHub",
          "status": "Disabled",
          "uri": "https://github.com/Azure/azure-devtestlab.git"
        },
        {
          "armTemplateFolderPath": "/Environments",
          "branchRef": "master",
          "displayName": "Public Environment Repo",
          "name": "Public Environment Repo",
          "sourceType": "GitHub",
          "status": "Disabled",
          "uri": "https://github.com/Azure/azure-devtestlab.git"
        }
      ]
    },
    "artifactsStorageAccount": {
      "value": "<artifactsStorageAccount>"
    },
    "browserConnect": {
      "value": "Enabled"
    },
    "costs": {
      "value": {
        "cycleType": "CalendarMonth",
        "status": "Enabled",
        "target": 450,
        "thresholdValue100DisplayOnChart": "Enabled",
        "thresholdValue100SendNotificationWhenExceeded": "Enabled"
      }
    },
    "disableAutoUpgradeCseMinorVersion": {
      "value": true
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "encryptionDiskEncryptionSetId": {
      "value": "<encryptionDiskEncryptionSetId>"
    },
    "encryptionType": {
      "value": "EncryptionAtRestWithCustomerKey"
    },
    "environmentPermission": {
      "value": "Contributor"
    },
    "extendedProperties": {
      "value": {
        "RdpConnectionType": "7"
      }
    },
    "isolateLabResources": {
      "value": "Enabled"
    },
    "labStorageType": {
      "value": "Premium"
    },
    "location": {
      "value": "<location>"
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
    "managementIdentitiesResourceIds": {
      "value": [
        "<managedIdentityResourceId>"
      ]
    },
    "notificationchannels": {
      "value": [
        {
          "description": "Integration configured for auto-shutdown",
          "emailRecipient": "mail@contosodtlmail.com",
          "events": [
            {
              "eventName": "AutoShutdown"
            }
          ],
          "name": "autoShutdown",
          "notificationLocale": "en",
          "webHookUrl": "https://webhook.contosotest.com"
        },
        {
          "events": [
            {
              "eventName": "Cost"
            }
          ],
          "name": "costThreshold",
          "webHookUrl": "https://webhook.contosotest.com"
        }
      ]
    },
    "policies": {
      "value": [
        {
          "evaluatorType": "MaxValuePolicy",
          "factData": "<factData>",
          "factName": "UserOwnedLabVmCountInSubnet",
          "name": "<name>",
          "threshold": "1"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "UserOwnedLabVmCount",
          "name": "MaxVmsAllowedPerUser",
          "threshold": "2"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "UserOwnedLabPremiumVmCount",
          "name": "MaxPremiumVmsAllowedPerUser",
          "status": "Disabled",
          "threshold": "1"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "LabVmCount",
          "name": "MaxVmsAllowedPerLab",
          "threshold": "3"
        },
        {
          "evaluatorType": "MaxValuePolicy",
          "factName": "LabPremiumVmCount",
          "name": "MaxPremiumVmsAllowedPerLab",
          "threshold": "2"
        },
        {
          "evaluatorType": "AllowedValuesPolicy",
          "factData": "",
          "factName": "LabVmSize",
          "name": "AllowedVmSizesInLab",
          "status": "Enabled",
          "threshold": "<threshold>"
        },
        {
          "evaluatorType": "AllowedValuesPolicy",
          "factName": "ScheduleEditPermission",
          "name": "ScheduleEditPermission",
          "threshold": "<threshold>"
        },
        {
          "evaluatorType": "AllowedValuesPolicy",
          "factName": "GalleryImage",
          "name": "GalleryImage",
          "threshold": "<threshold>"
        },
        {
          "description": "Public Environment Policy",
          "evaluatorType": "AllowedValuesPolicy",
          "factName": "EnvironmentTemplate",
          "name": "EnvironmentTemplate",
          "threshold": "<threshold>"
        }
      ]
    },
    "premiumDataDisks": {
      "value": "Enabled"
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
    "schedules": {
      "value": [
        {
          "dailyRecurrence": {
            "time": "0000"
          },
          "name": "LabVmsShutdown",
          "notificationSettingsStatus": "Enabled",
          "notificationSettingsTimeInMinutes": 30,
          "status": "Enabled",
          "taskType": "LabVmsShutdownTask",
          "timeZoneId": "AUS Eastern Standard Time"
        },
        {
          "name": "LabVmAutoStart",
          "status": "Enabled",
          "taskType": "LabVmsStartupTask",
          "timeZoneId": "AUS Eastern Standard Time",
          "weeklyRecurrence": {
            "time": "0700",
            "weekdays": [
              "Friday",
              "Monday",
              "Thursday",
              "Tuesday",
              "Wednesday"
            ]
          }
        }
      ]
    },
    "support": {
      "value": {
        "enabled": "Enabled",
        "markdown": "DevTest Lab support text. <br> New line. It also supports Markdown"
      }
    },
    "tags": {
      "value": {
        "hidden-title": "This is visible in the resource name",
        "labName": "dtllwaf001",
        "resourceType": "DevTest Lab"
      }
    },
    "virtualnetworks": {
      "value": [
        {
          "allowedSubnets": [
            {
              "allowPublicIp": "Allow",
              "labSubnetName": "<labSubnetName>",
              "resourceId": "<resourceId>"
            }
          ],
          "description": "lab virtual network description",
          "externalProviderResourceId": "<externalProviderResourceId>",
          "name": "<name>",
          "subnetOverrides": [
            {
              "labSubnetName": "<labSubnetName>",
              "resourceId": "<resourceId>",
              "sharedPublicIpAddressConfiguration": {
                "allowedPorts": [
                  {
                    "backendPort": 3389,
                    "transportProtocol": "Tcp"
                  },
                  {
                    "backendPort": 22,
                    "transportProtocol": "Tcp"
                  }
                ]
              },
              "useInVmCreationPermission": "Allow",
              "usePublicIpAddressPermission": "Allow"
            }
          ]
        }
      ]
    },
    "vmCreationResourceGroupId": {
      "value": "<vmCreationResourceGroupId>"
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
| [`name`](#parameter-name) | string | The name of the lab. |

**Conditional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`encryptionDiskEncryptionSetId`](#parameter-encryptiondiskencryptionsetid) | string | The Disk Encryption Set Resource ID used to encrypt OS and data disks created as part of the the lab. Required if encryptionType is set to "EncryptionAtRestWithCustomerKey". |
| [`notificationchannels`](#parameter-notificationchannels) | array | Notification Channels to create for the lab. Required if the schedules property "notificationSettingsStatus" is set to "Enabled. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`announcement`](#parameter-announcement) | object | The properties of any lab announcement associated with this lab. |
| [`artifactsources`](#parameter-artifactsources) | array | Artifact sources to create for the lab. |
| [`artifactsStorageAccount`](#parameter-artifactsstorageaccount) | string | The resource ID of the storage account used to store artifacts and images by the lab. Also used for defaultStorageAccount, defaultPremiumStorageAccount and premiumDataDiskStorageAccount properties. If left empty, a default storage account will be created by the lab and used. |
| [`browserConnect`](#parameter-browserconnect) | string | Enable browser connect on virtual machines if the lab's VNETs have configured Azure Bastion. |
| [`costs`](#parameter-costs) | object | Costs to create for the lab. |
| [`disableAutoUpgradeCseMinorVersion`](#parameter-disableautoupgradecseminorversion) | bool | Disable auto upgrade custom script extension minor version. |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable telemetry via a Globally Unique Identifier (GUID). |
| [`encryptionType`](#parameter-encryptiontype) | string | Specify how OS and data disks created as part of the lab are encrypted. |
| [`environmentPermission`](#parameter-environmentpermission) | string | The access rights to be granted to the user when provisioning an environment. |
| [`extendedProperties`](#parameter-extendedproperties) | object | Extended properties of the lab used for experimental features. |
| [`isolateLabResources`](#parameter-isolatelabresources) | string | Enable lab resources isolation from the public internet. |
| [`labStorageType`](#parameter-labstoragetype) | string | Type of storage used by the lab. It can be either Premium or Standard. |
| [`location`](#parameter-location) | string | Location for all Resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`managedIdentities`](#parameter-managedidentities) | object | The managed identity definition for this resource. |
| [`managementIdentitiesResourceIds`](#parameter-managementidentitiesresourceids) | array | The resource ID(s) to assign to the virtual machines associated with this lab. |
| [`mandatoryArtifactsResourceIdsLinux`](#parameter-mandatoryartifactsresourceidslinux) | array | The ordered list of artifact resource IDs that should be applied on all Linux VM creations by default, prior to the artifacts specified by the user. |
| [`mandatoryArtifactsResourceIdsWindows`](#parameter-mandatoryartifactsresourceidswindows) | array | The ordered list of artifact resource IDs that should be applied on all Windows VM creations by default, prior to the artifacts specified by the user. |
| [`policies`](#parameter-policies) | array | Policies to create for the lab. |
| [`premiumDataDisks`](#parameter-premiumdatadisks) | string | The setting to enable usage of premium data disks. When its value is "Enabled", creation of standard or premium data disks is allowed. When its value is "Disabled", only creation of standard data disks is allowed. Default is "Disabled". |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalIds' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |
| [`schedules`](#parameter-schedules) | array | Schedules to create for the lab. |
| [`support`](#parameter-support) | object | The properties of any lab support message associated with this lab. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |
| [`virtualnetworks`](#parameter-virtualnetworks) | array | Virtual networks to create for the lab. |
| [`vmCreationResourceGroupId`](#parameter-vmcreationresourcegroupid) | string | Resource Group allocation for virtual machines. If left empty, virtual machines will be deployed in their own Resource Groups. Default is the same Resource Group for DevTest Lab. |

### Parameter: `announcement`

The properties of any lab announcement associated with this lab.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `artifactsources`

Artifact sources to create for the lab.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `artifactsStorageAccount`

The resource ID of the storage account used to store artifacts and images by the lab. Also used for defaultStorageAccount, defaultPremiumStorageAccount and premiumDataDiskStorageAccount properties. If left empty, a default storage account will be created by the lab and used.
- Required: No
- Type: string
- Default: `''`

### Parameter: `browserConnect`

Enable browser connect on virtual machines if the lab's VNETs have configured Azure Bastion.
- Required: No
- Type: string
- Default: `'Disabled'`
- Allowed:
  ```Bicep
  [
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `costs`

Costs to create for the lab.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `disableAutoUpgradeCseMinorVersion`

Disable auto upgrade custom script extension minor version.
- Required: No
- Type: bool
- Default: `False`

### Parameter: `enableDefaultTelemetry`

Enable telemetry via a Globally Unique Identifier (GUID).
- Required: No
- Type: bool
- Default: `True`

### Parameter: `encryptionDiskEncryptionSetId`

The Disk Encryption Set Resource ID used to encrypt OS and data disks created as part of the the lab. Required if encryptionType is set to "EncryptionAtRestWithCustomerKey".
- Required: No
- Type: string
- Default: `''`

### Parameter: `encryptionType`

Specify how OS and data disks created as part of the lab are encrypted.
- Required: No
- Type: string
- Default: `'EncryptionAtRestWithPlatformKey'`
- Allowed:
  ```Bicep
  [
    'EncryptionAtRestWithCustomerKey'
    'EncryptionAtRestWithPlatformKey'
  ]
  ```

### Parameter: `environmentPermission`

The access rights to be granted to the user when provisioning an environment.
- Required: No
- Type: string
- Default: `'Reader'`
- Allowed:
  ```Bicep
  [
    'Contributor'
    'Reader'
  ]
  ```

### Parameter: `extendedProperties`

Extended properties of the lab used for experimental features.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `isolateLabResources`

Enable lab resources isolation from the public internet.
- Required: No
- Type: string
- Default: `'Enabled'`
- Allowed:
  ```Bicep
  [
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `labStorageType`

Type of storage used by the lab. It can be either Premium or Standard.
- Required: No
- Type: string
- Default: `'Premium'`
- Allowed:
  ```Bicep
  [
    'Premium'
    'Standard'
    'StandardSSD'
  ]
  ```

### Parameter: `location`

Location for all Resources.
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

The managed identity definition for this resource.
- Required: No
- Type: object


| Name | Required | Type | Description |
| :-- | :-- | :--| :-- |
| [`userAssignedResourcesIds`](#parameter-managedidentitiesuserassignedresourcesids) | Yes | array | Optional. The resource ID(s) to assign to the resource. |

### Parameter: `managedIdentities.userAssignedResourcesIds`

Optional. The resource ID(s) to assign to the resource.

- Required: Yes
- Type: array

### Parameter: `managementIdentitiesResourceIds`

The resource ID(s) to assign to the virtual machines associated with this lab.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `mandatoryArtifactsResourceIdsLinux`

The ordered list of artifact resource IDs that should be applied on all Linux VM creations by default, prior to the artifacts specified by the user.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `mandatoryArtifactsResourceIdsWindows`

The ordered list of artifact resource IDs that should be applied on all Windows VM creations by default, prior to the artifacts specified by the user.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `name`

The name of the lab.
- Required: Yes
- Type: string

### Parameter: `notificationchannels`

Notification Channels to create for the lab. Required if the schedules property "notificationSettingsStatus" is set to "Enabled.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `policies`

Policies to create for the lab.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `premiumDataDisks`

The setting to enable usage of premium data disks. When its value is "Enabled", creation of standard or premium data disks is allowed. When its value is "Disabled", only creation of standard data disks is allowed. Default is "Disabled".
- Required: No
- Type: string
- Default: `'Disabled'`
- Allowed:
  ```Bicep
  [
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `roleAssignments`

Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalIds' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
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

### Parameter: `schedules`

Schedules to create for the lab.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `support`

The properties of any lab support message associated with this lab.
- Required: No
- Type: object
- Default: `{}`

### Parameter: `tags`

Tags of the resource.
- Required: No
- Type: object

### Parameter: `virtualnetworks`

Virtual networks to create for the lab.
- Required: No
- Type: array
- Default: `[]`

### Parameter: `vmCreationResourceGroupId`

Resource Group allocation for virtual machines. If left empty, virtual machines will be deployed in their own Resource Groups. Default is the same Resource Group for DevTest Lab.
- Required: No
- Type: string
- Default: `[resourceGroup().id]`


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the lab. |
| `resourceGroupName` | string | The resource group the lab was deployed into. |
| `resourceId` | string | The resource ID of the lab. |
| `systemAssignedMIPrincipalId` | string | The principal ID of the system assigned identity. |
| `systemAssignedPrincipalId` | string | The principal ID of the system assigned identity. |
| `uniqueIdentifier` | string | The unique identifier for the lab. Used to track tags that the lab applies to each resource that it creates. |

## Cross-referenced modules

_None_
