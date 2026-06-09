# Ballerina Microsoft.sharepoint.pages connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages.svg)](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/microsoft.sharepoint.pages.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%microsoft.sharepoint.pages)

[Microsoft SharePoint](https://www.microsoft.com/en-us/microsoft-365/sharepoint/collaboration) is a web-based collaboration and content management platform that enables organizations to create, manage, and share pages, documents, and sites across teams and enterprises.

The `ballerinax/microsoft.sharepoint.pages` package offers APIs to connect and interact with the [Microsoft SharePoint Pages API](https://learn.microsoft.com/en-us/graph/api/resources/sitepage?view=graph-rest-1.0) endpoints, specifically based on [Microsoft Graph REST API v1.0](https://learn.microsoft.com/en-us/graph/api/resources/sitepage?view=graph-rest-1.0).

## Setup guide

To use the Microsoft SharePoint Pages connector, you must have access to the Microsoft SharePoint API through a [Microsoft Azure developer account](https://portal.azure.com/) and obtain an OAuth 2.0 access token by registering an application in Azure Active Directory. If you do not have a Microsoft account, you can sign up for one [here](https://account.microsoft.com/account).

### Step 1: Create a Microsoft Account and Set Up SharePoint Access

1. Navigate to the [Microsoft 365 website](https://www.microsoft.com/en-us/microsoft-365) and sign up for an account or log in if you already have one.

2. Ensure you have a Microsoft 365 Business Basic, Business Standard, Business Premium, or an Enterprise (E1, E3, or E5) plan, as SharePoint Online and its API capabilities are restricted to users on these plans. SharePoint Pages API features may require Microsoft 365 E3 or higher for full functionality.

### Step 2: Register an Application and Generate Credentials

1. Log in to the [Microsoft Azure Portal](https://portal.azure.com/) using your Microsoft 365 account credentials.

2. In the left-hand navigation menu, select **Azure Active Directory** (or search for "Microsoft Entra ID" in the top search bar).

3. In the left panel, navigate to **App registrations** and click **New registration**.

4. Enter a name for your application, select the appropriate **Supported account types** (e.g., "Accounts in this organizational directory only"), and click **Register**.

5. Once the application is registered, note down the **Application (client) ID** and **Directory (tenant) ID** from the Overview page.

6. Navigate to **Certificates & secrets** in the left panel, click **New client secret**, provide a description and expiry period, then click **Add**. Copy the generated **client secret value** immediately.

7. Navigate to **API permissions**, click **Add a permission**, select **Microsoft Graph**, and add the required SharePoint permissions such as `Sites.Read.All`, `Sites.ReadWrite.All` depending on your use case. Click **Grant admin consent** to approve the permissions.

8. Construct the `tokenUrl` using the **Directory (tenant) ID** obtained in step 5:

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

#### Create a new page in a SharePoint site

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

1. [Vertical section webpart audit](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/vertical-section-webpart-audit) - Illustrates how to audit web parts located within vertical sections across SharePoint pages.
2. [Webpart audit cleanup](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/webpart-audit-cleanup) - Demonstrates how to identify and clean up web parts on SharePoint pages as part of an audit process.
3. [Sharepoint page audit enrichment](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/sharepoint-page-audit-enrichment) - Illustrates how to enrich SharePoint page audit data with additional metadata for comprehensive reporting.

## Useful Links

* For more information go to the [`microsoft.sharepoint.pages` package](https://central.ballerina.io/ballerinax/microsoft.sharepoint.pages/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
