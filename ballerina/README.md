## Overview

[Microsoft SharePoint](https://www.microsoft.com/en-us/microsoft-365/sharepoint/collaboration) is a cloud-based collaboration and content management platform that enables organizations to create, manage, and share pages, sites, and documents seamlessly across teams and enterprises.

The `ballerinax/microsoft.sharepoint.pages` package offers APIs to connect and interact with [Microsoft SharePoint Pages API](https://learn.microsoft.com/en-us/graph/api/resources/sitepage?view=graph-rest-1.0) endpoints, specifically based on [Microsoft Graph REST API v1.0](https://learn.microsoft.com/en-us/graph/api/resources/sitepage?view=graph-rest-1.0).

## Setup guide

To use the Microsoft SharePoint Pages connector, you must have access to the Microsoft SharePoint API through a [Microsoft Azure developer account](https://portal.azure.com/) and obtain client credentials by registering an application in Azure Active Directory. If you do not have a Microsoft account, you can sign up for one [here](https://account.microsoft.com/account).

### Step 1: Create a Microsoft Account and Set Up SharePoint Access

1. Navigate to the [Microsoft 365 website](https://www.microsoft.com/en-us/microsoft-365) and sign up for an account or log in if you already have one.

2. Ensure you have a Microsoft 365 Business Basic, Business Standard, Business Premium, or an Enterprise (E1, E3, or E5) plan, as SharePoint Online and its API capabilities are restricted to users on these plans. SharePoint Pages API features may require Microsoft 365 E3 or higher for full functionality.

### Step 2: Register an Application and Generate Credentials

1. Log in to the [Microsoft Azure Portal](https://portal.azure.com/) using your Microsoft 365 account credentials.

2. In the left-hand navigation menu, select **Microsoft Entra ID** in the top search bar.

3. In the left panel, navigate to **App registrations** and click **New registration**.

   ![New application registration](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/new-application-registration.png)

4. Enter a name for your application, select the appropriate **Supported account types** (e.g., "Single tenant only"), and click **Register**.

   ![Application registration details](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/application-registration-details.png)

5. Once the application is registered, note down the **Application (client) ID** and **Directory (tenant) ID** from the Overview page.

   ![Client ID and Tenant ID](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/client-id-and-tenant-id.png)

6. Navigate to **Certificates & secrets** in the left panel, click **New client secret**, provide a description and expiry period, then click **Add**. Copy the generated **client secret value** immediately.

   ![Create client secret](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/create-client-secret.png)

7. Navigate to **API permissions** in the left panel and click **Add a permission**.

   ![Add API permission](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/add-api-permission.png)

8. Select **Microsoft Graph** from the available API options.

   ![Microsoft Graph API permission](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/microsoft-graph-api-permission.png)

9. Select the required SharePoint permissions (`Sites.Read.All` and `Sites.ReadWrite.All`) depending on your use case, then click **Add permissions**.

   ![API site permissions](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/api-site-permissions.png)

10. Click **Grant admin consent** to approve the permissions for your organization.

    ![Grant admin consent](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/refs/heads/main/docs/resources/grant-admin-consent.png)

11. Construct the `tokenUrl` using the **Directory (tenant) ID** obtained in step 5:

```text
https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token
```

This is the OAuth 2.0 token endpoint the connector uses to exchange your `clientId` and `clientSecret` for an access token with the `https://graph.microsoft.com/.default` scope.

## Quickstart

To use the `microsoft.sharepoint.pages` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/microsoft.sharepoint.pages;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the credentials obtained above:

```toml
clientId = "<CLIENT_ID>"
clientSecret = "<CLIENT_SECRET>"
tokenUrl = "https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token"
```

2. Instantiate a `pages:Client` with the obtained credentials.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string tokenUrl = ?;

final pages:Client sharepointPagesClient = check new({
    auth: {
        clientId,
        clientSecret,
        tokenUrl
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### List pages in a SharePoint site

```ballerina
public function main() returns error? {
    string siteId = "add-the-site-id";

    pages:BaseSitePageCollectionResponse response = check sharepointPagesClient->listPages(siteId);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `microsoft.sharepoint.pages` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples), covering the following use cases:

1. [Vertical section webpart audit](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/vertical-section-webpart-audit) - Inspect and report on web parts placed within vertical sections across SharePoint pages.
2. [Webpart audit cleanup](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/webpart-audit-cleanup) - Identify and remove outdated or unused web parts from SharePoint pages as part of a cleanup process.
3. [SharePoint page audit enrichment](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/sharepoint-page-audit-enrichment) - Enrich SharePoint page audit data with additional metadata to produce comprehensive audit reports.
