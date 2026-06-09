# Webpart Audit Cleanup

This example demonstrates how to perform a web part audit and cleanup on a Microsoft SharePoint site page. The script retrieves all web parts on a specified page, gets the position of a specific web part, and then deletes it from the page.

## Prerequisites

1. **Microsoft SharePoint Setup**
   > Refer to the [Microsoft SharePoint Pages connector setup guide](https://central.ballerina.io/ballerinax/microsoft.sharepoint.pages/latest) to obtain the required credentials.

2. **Configuration**

   Create a `Config.toml` file in the project root and add your credentials:

   ```toml
   tenantId = "<Your Tenant ID>"
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   siteId = "<Your Site ID>"
   pageId = "<Your Page ID>"
   webPartId = "<Your Web Part ID>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console as it retrieves web parts, fetches the position of the specified web part, and deletes it from the page.

```shell
bal run
```
