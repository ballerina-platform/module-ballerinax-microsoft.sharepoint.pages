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

import ballerina/http;

final string mockPageId = "3a6b8c2d-4e5f-6a7b-8c9d-0e1f2a3b4c5d";
final string mockCreatedDateTime = "2026-01-01T00:00:00Z";
final string mockWebUrl = "https://contoso.sharepoint.com/SitePages/test-page.aspx";

# Returns the canonical mock page used across GET endpoints.
isolated function getMockPage() returns MicrosoftGraphBaseSitePage {
    MicrosoftGraphBaseSitePage page = {
        id: mockPageId,
        name: "test-page.aspx",
        title: "Test SharePoint Page",
        pageLayout: "article",
        webUrl: mockWebUrl,
        createdDateTime: mockCreatedDateTime,
        lastModifiedDateTime: mockCreatedDateTime
    };
    return page;
}

service / on new http:Listener(9090) {

    # List baseSitePages — returns a single-item collection containing the mock page.
    resource function get [string siteId]/pages()
            returns MicrosoftGraphBaseSitePageCollectionResponse {
        MicrosoftGraphBaseSitePage[] pages = [getMockPage()];
        return {value: pages};
    }

    # Create a page — rejects payloads with no title (400), otherwise echoes payload with a mock ID.
    resource function post [string siteId]/pages(@http:Payload MicrosoftGraphBaseSitePage payload)
            returns MicrosoftGraphBaseSitePage|http:BadRequest {
        if payload?.title == () {
            return http:BAD_REQUEST;
        }
        MicrosoftGraphBaseSitePage newPage = {
            id: mockPageId,
            name: payload?.name ?: "new-page.aspx",
            title: payload?.title,
            pageLayout: payload?.pageLayout ?: "article",
            webUrl: mockWebUrl,
            createdDateTime: mockCreatedDateTime,
            lastModifiedDateTime: mockCreatedDateTime
        };
        return newPage;
    }

    # Get a single baseSitePage — returns mock data for the known ID, 404 otherwise.
    resource function get [string siteId]/pages/[string pageId]()
            returns MicrosoftGraphBaseSitePage|http:NotFound {
        if pageId != mockPageId {
            return http:NOT_FOUND;
        }
        return getMockPage();
    }

    # Update a page — returns 204 for the known ID, 404 otherwise.
    resource function patch [string siteId]/pages/[string pageId](@http:Payload MicrosoftGraphBaseSitePage payload)
            returns http:NoContent|http:NotFound {
        if pageId != mockPageId {
            return http:NOT_FOUND;
        }
        return http:NO_CONTENT;
    }

    # Delete a page — returns 204 for the known ID, 404 otherwise.
    resource function delete [string siteId]/pages/[string pageId]()
            returns http:NoContent|http:NotFound {
        if pageId != mockPageId {
            return http:NOT_FOUND;
        }
        return http:NO_CONTENT;
    }
}
