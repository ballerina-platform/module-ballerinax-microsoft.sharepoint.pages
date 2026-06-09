// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

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
}
