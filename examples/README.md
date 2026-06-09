# Examples

The `microsoft.sharepoint.pages` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples), covering use cases like webpart audit cleanup and SharePoint page audit enrichment.

1. [Vertical section webpart audit](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/vertical-section-webpart-audit) - Inspect and report on web parts placed within vertical sections across SharePoint pages.

2. [Webpart audit cleanup](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/webpart-audit-cleanup) - Identify and remove outdated or unused web parts from SharePoint pages as part of a cleanup process.

3. [SharePoint page audit enrichment](https://github.com/ballerina-platform/module-ballerinax-microsoft.sharepoint.pages/tree/main/examples/sharepoint-page-audit-enrichment) - Enrich SharePoint page audit data with additional metadata to produce comprehensive audit reports.

## Prerequisites

1. Generate Microsoft SharePoint credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/microsoft.sharepoint.pages/latest#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    token = "<Access Token>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```
