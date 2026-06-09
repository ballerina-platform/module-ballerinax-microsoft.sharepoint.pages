# Vertical Section Webpart Audit

This example demonstrates how to audit and manage web parts in a SharePoint page's vertical section by retrieving all existing web parts, adding a new announcement web part, and updating an existing web part using the Microsoft SharePoint Pages API.

## Prerequisites

1. **Microsoft SharePoint Setup**
   > Refer to the [Microsoft SharePoint Pages connector setup guide](https://central.ballerina.io/ballerinax/microsoft.sharepoint.pages/latest) to obtain the required credentials and configure access to your SharePoint site.

2. For this example, create a `Config.toml` file in the project root with your credentials:

```toml
clientId = "<Your Client ID>"
clientSecret = "<Your Client Secret>"
tokenUrl = "https://login.microsoftonline.com/<Your Tenant ID>/oauth2/v2.0/token"
siteId = "<Your Site ID>"
pageId = "<Your Page ID>"
existingWebPartId = "<Your Existing Web Part ID>"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console as it completes each step of the audit and refresh workflow.

```shell
bal run
```
