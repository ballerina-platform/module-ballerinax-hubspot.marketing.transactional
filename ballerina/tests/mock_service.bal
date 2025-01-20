// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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
import ballerina/log;

listener http:Listener httpListener = new (9090);

http:Service mockService = service object {

    resource isolated function delete smtp\-tokens/[string tokenId](map<string|string[]> headers = {}) returns http:Response {
        http:Response response = new;
        response.statusCode = 204;
        return response;
    }

    resource isolated function get smtp\-tokens/[string tokenId](map<string|string[]> headers = {}) returns SmtpApiTokenView {
        return {
            "createdAt": "2025-01-08T13:58:35.669Z",
            "password": "string",
            "createdBy": "string",
            "createContact": true,
            "id": "123",
            "emailCampaignId": "string",
            "campaignName": "string"

        };
    }

    resource isolated function post single\-email/send(@http:Payload PublicSingleSendRequestEgg payload, map<string|string[]> headers = {}) returns EmailSendStatusView {
        return {
            "eventId": {
                "created": "2025-01-08T13:58:35.631Z",
                "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
            },
            "completedAt": "2025-01-08T13:58:35.631Z",
            "statusId": "string",
            "sendResult": "SENT",
            "requestedAt": "2025-01-08T13:58:35.631Z",
            "startedAt": "2025-01-08T13:58:35.631Z",
            "status": "PENDING"
        };
    }

    resource isolated function post smtp\-tokens(@http:Payload SmtpApiTokenRequestEgg payload, map<string|string[]> headers = {}) returns SmtpApiTokenView {
        return {
            "createdAt": "2025-01-08T13:58:35.710Z",
            "password": "string",
            "createdBy": "string",
            "createContact": true,
            "id": "string",
            "emailCampaignId": "string",
            "campaignName": "Campaign2"
        };

    }

    resource isolated function post smtp\-tokens/[string tokenId]/password\-reset(map<string|string[]> headers = {}) returns SmtpApiTokenView {
        return {
            "createdAt": "2025-01-08T13:58:35.733Z",
            "password": "string",
            "createdBy": "string",
            "createContact": true,
            "id": "234",
            "emailCampaignId": "string",
            "campaignName": "string"
        };
    }

    resource function get smtp\-tokens(map<string|string[]> headers = {}) returns CollectionResponseSmtpApiTokenViewForwardPaging {
        CollectionResponseSmtpApiTokenViewForwardPaging response = {
            "paging": {
                "next": {
                    "link": "string",
                    "after": "string"
                }
            },
            "results": [
                {
                    "createdAt": "2025-01-08T13:58:35.669Z",
                    "password": "string",
                    "createdBy": "string",
                    "createContact": true,
                    "id": "123",
                    "emailCampaignId": "string",
                    "campaignName": "string"
                },

                {
                    "createdAt": "2025-01-08T13:58:35.665Z",
                    "password": "string",
                    "createdBy": "string",
                    "createContact": true,
                    "id": "124",
                    "emailCampaignId": "string",
                    "campaignName": "string"
                }
            ]
        };
        return response;
    }
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skiping mock server initialization as the tests are running on live server");
        return;
    }
    log:printInfo("Initiating mock server");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}