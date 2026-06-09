import ballerina/io;
import ballerinax/microsoft.sharepoint.pages;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string tokenUrl = ?;
configurable string siteId = ?;
configurable string pageId = ?;
configurable string existingWebPartId = ?;

public function main() returns error? {
    pages:ConnectionConfig connectionConfig = {
        auth: {
            clientId,
            clientSecret,
            tokenUrl,
            scopes: ["https://graph.microsoft.com/.default"]
        }
    };

    pages:Client sharepointClient = check new (connectionConfig);

    io:println("=== Step 1: Auditing Web Parts in Vertical Section ===");

    pages:MicrosoftGraphWebPartCollectionResponse webPartsResult = check sharepointClient->sitesPagesAsSitePageCanvasLayoutVerticalSectionListWebparts(siteId, pageId);
    io:println("Successfully retrieved web parts in vertical section:");
    io:println(webPartsResult);

    io:println("\n=== Step 2: Adding New Announcement Web Part to Vertical Section ===");

    pages:MicrosoftGraphWebPart newWebPart = {
        id: "new-announcement-webpart"
    };

    pages:MicrosoftGraphWebPart postResult = check sharepointClient->sitesPagesAsSitePageCanvasLayoutVerticalSectionCreateWebparts(siteId, pageId, newWebPart);
    io:println("Successfully added new announcement web part:");
    io:println(postResult);

    io:println("\n=== Step 3: Updating Existing Web Part in Vertical Section ===");

    pages:MicrosoftGraphWebPart updatedWebPart = {
        id: existingWebPartId
    };

    check sharepointClient->sitesPagesAsSitePageCanvasLayoutVerticalSectionUpdateWebparts(siteId, pageId, existingWebPartId, updatedWebPart);
    io:println("Successfully updated existing web part with new navigation links.");

    io:println("\n=== Vertical Section Web Part Audit and Refresh Workflow Completed ===");
}
