import ballerina/io;
import ballerinax/microsoft.sharepoint.pages;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string tokenUrl = ?;
configurable string siteId = ?;
configurable string pageId = ?;
configurable string webPartId = ?;

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

    // Step 1: Retrieve all web parts on the site page
    io:println("Step 1: Retrieving all web parts on the site page...");
    pages:MicrosoftGraphWebPartCollectionResponse webPartsResponse = check sharepointClient->sitesPagesAsSitePageListWebParts(siteId, pageId);
    io:println("Web parts retrieved successfully:");
    io:println(webPartsResponse);

    // Step 2: Get the position of the specific web part
    io:println("\nStep 2: Getting position of the specific web part...");
    pages:WebPartPositionResponse webPartPosition = check sharepointClient->sitesSitePagesBaseSitePageMicrosoftGraphSitePageWebPartsWebPartGetPositionOfWebPart(siteId, pageId, webPartId);
    io:println("Web part position details:");
    io:println(webPartPosition);

    // Step 3: Delete the identified web part from the page
    io:println("\nStep 3: Deleting the identified web part from the page...");
    check sharepointClient->sitesPagesAsSitePageDeleteWebParts(siteId, pageId, webPartId);
    io:println("Web part with ID '" + webPartId + "' has been successfully deleted from the page.");

    io:println("\nWeb Part Audit and Cleanup Workflow completed successfully.");
}
