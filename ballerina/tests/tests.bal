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

import ballerina/test;
import ballerina/os;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string serviceUrl = os:getEnv("SERVICE_URL");
configurable string clientId = os:getEnv("CLIENT_ID");
configurable string clientSecret = os:getEnv("CLIENT_SECRET");
configurable string tokenUrl = os:getEnv("TOKEN_URL");
configurable string siteId = os:getEnv("SITE_ID") == "" ? "mock-site-id" : os:getEnv("SITE_ID");

isolated string createdPageId = "";

final Client sharepoint = check initClient();

isolated function initClient() returns Client|error {
    if isLiveServer {
        return check new Client(
            {
                auth: {
                    clientId,
                    clientSecret,
                    tokenUrl
                }
            },
            serviceUrl
        );
    }
    return check new Client({auth: {token: "mock-token"}}, "http://localhost:9090");
}

// Test: Create a SharePoint page
@test:Config {groups: ["live_test", "mock_test"]}
isolated function testCreatePage() returns error? {
    MicrosoftGraphBaseSitePage payload = {
        title: "Test SharePoint Page",
        name: "test-page.aspx",
        pageLayout: "article"
    };
    MicrosoftGraphBaseSitePage response = check sharepoint->sitesCreatePages(siteId, payload);
    test:assertTrue(response?.id !is (), msg = "Created page should have an ID");
    test:assertEquals(response?.title, "Test SharePoint Page",
            msg = "Created page title should match the request payload");
    lock {
        createdPageId = response?.id ?: "";
    }
}

// Test: List pages — collection should be non-empty after creating a page
@test:Config {dependsOn: [testCreatePage], groups: ["live_test", "mock_test"]}
isolated function testListPages() returns error? {
    MicrosoftGraphBaseSitePageCollectionResponse response = check sharepoint->sitesListPages(siteId);
    MicrosoftGraphBaseSitePage[] pages = response.value ?: [];
    test:assertTrue(pages.length() > 0, msg = "Page list should contain at least one page");
}

// Test: Get a specific page by ID
@test:Config {dependsOn: [testCreatePage], groups: ["live_test", "mock_test"]}
isolated function testGetPage() returns error? {
    string pageId;
    lock {
        pageId = createdPageId;
    }
    MicrosoftGraphBaseSitePage response = check sharepoint->sitesGetPages(siteId, pageId);
    test:assertEquals(response?.id, pageId, msg = "Retrieved page ID should match the created page");
    test:assertEquals(response?.title, "Test SharePoint Page",
            msg = "Retrieved page title should match");
}

// Test: Update (PATCH) an existing page — expects 204 No Content (returns ())
@test:Config {dependsOn: [testGetPage], groups: ["live_test", "mock_test"]}
isolated function testUpdatePage() returns error? {
    string pageId;
    lock {
        pageId = createdPageId;
    }
    MicrosoftGraphBaseSitePage payload = {
        title: "Updated SharePoint Page"
    };
    error? response = sharepoint->sitesUpdatePages(siteId, pageId, payload);
    test:assertEquals(response, (), msg = "Page update should return no error (204 No Content)");
}

// Test: Delete a page — expects 204 No Content (returns ())
@test:Config {dependsOn: [testUpdatePage], groups: ["live_test", "mock_test"]}
isolated function testDeletePage() returns error? {
    string pageId;
    lock {
        pageId = createdPageId;
    }
    error? response = sharepoint->sitesDeletePages(siteId, pageId);
    test:assertEquals(response, (), msg = "Page deletion should return no error (204 No Content)");
}

// Test (negative): GET a page with an ID that does not exist — expects an error
@test:Config {groups: ["mock_test"]}
isolated function testGetNonExistentPage() {
    MicrosoftGraphBaseSitePage|error response =
            sharepoint->sitesGetPages(siteId, "00000000-0000-0000-0000-000000000000");
    test:assertTrue(response is error,
            msg = "Getting a non-existent page should return an error (404)");
}

// Test (negative): DELETE a page with an ID that does not exist — expects an error
@test:Config {groups: ["mock_test"]}
isolated function testDeleteNonExistentPage() {
    error? response =
            sharepoint->sitesDeletePages(siteId, "00000000-0000-0000-0000-000000000000");
    test:assertTrue(response is error,
            msg = "Deleting a non-existent page should return an error (404)");
}

// Test (negative): PATCH a page with an ID that does not exist — expects an error
@test:Config {groups: ["mock_test"]}
isolated function testPatchNonExistentPage() {
    MicrosoftGraphBaseSitePage payload = {title: "Should Fail"};
    error? response =
            sharepoint->sitesUpdatePages(siteId, "00000000-0000-0000-0000-000000000000", payload);
    test:assertTrue(response is error,
            msg = "Patching a non-existent page should return an error (404)");
}

// Test (negative): Create a page without a title — expects an error (400 Bad Request)
@test:Config {groups: ["mock_test"]}
isolated function testCreatePageWithoutTitle() {
    MicrosoftGraphBaseSitePage payload = {
        name: "no-title-page.aspx",
        pageLayout: "article"
    };
    MicrosoftGraphBaseSitePage|error response = sharepoint->sitesCreatePages(siteId, payload);
    test:assertTrue(response is error,
            msg = "Creating a page without a title should return an error (400)");
}
