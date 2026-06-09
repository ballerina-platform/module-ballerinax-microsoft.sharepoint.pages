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
}
