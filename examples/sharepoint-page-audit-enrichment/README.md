# SharePoint Page Audit Enrichment

This example demonstrates how to automate a corporate intranet page audit and enrichment workflow using the Microsoft SharePoint Pages connector. The script lists all site pages, retrieves full page details including canvas layout, appends a standardized "Last Reviewed" banner web part section, and publishes the updated page for end-user visibility.

## Prerequisites

1. **Microsoft SharePoint Setup**
   > Refer to the [Microsoft SharePoint Pages connector setup guide](https://central.ballerina.io/ballerinax/microsoft.sharepoint.pages/latest) to register an Azure AD application and obtain the required credentials.

2. **Configuration**

   Create a `Config.toml` file in the project root and add your credentials:

   ```toml
   tenantId = "<Your Tenant ID>"
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   siteId = "<Your SharePoint Site ID>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress and results to the console.

```shell
bal run
```
