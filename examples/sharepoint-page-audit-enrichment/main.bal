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

    io:println("=== Corporate Intranet Page Audit and Enrichment Workflow ===");
    io:println("");

    // Step 1: List all existing site pages
    io:println("Step 1: Listing all site pages for audit...");
    pages:BaseSitePageCollectionResponse listPagesResult = check sharepointClient->listPages(siteId);

    io:println("Successfully retrieved site pages.");
    io:println("Site Pages Overview:");
    io:println(listPagesResult);
    io:println("");

    // Step 2: Retrieve full SitePage details including canvas layout
    io:println("Step 2: Retrieving full SitePage details with canvas layout...");

    pages:SitePage getPageResult = check sharepointClient->getPagesAsSitePage(siteId, pageId);

    io:println("Successfully retrieved SitePage details.");
    io:println("Page Details (including canvas layout):");
    io:println(getPageResult);
    io:println("");

    // Step 3: Add a new horizontal section to the canvas layout
    io:println("Step 3: Adding 'Last Reviewed' banner section to canvas layout...");

    string reviewedDate = "2024-01-15";
    string bannerHtml = "<div style='background-color:#0078d4;color:white;padding:10px;'><strong>Last Reviewed:</strong> This page was last reviewed and approved by the IT Governance team on " + reviewedDate + ". Please contact the content owner for updates.</div>";

    pages:HorizontalSection reviewSection = {
        id: "last-reviewed-section",
        emphasis: "strong",
        columns: [
            {
                id: "last-reviewed-column",
                width: 12,
                webparts: [
                    {id: "last-reviewed-webpart"}
                ]
            }
        ]
    };

    pages:CanvasLayout canvasLayoutPayload = {
        horizontalSections: [reviewSection]
    };

    check sharepointClient->pagesAsSitePageUpdateCanvasLayout(siteId, pageId, canvasLayoutPayload);

    io:println("Successfully added 'Last Reviewed' banner section to the page canvas layout.");
}
