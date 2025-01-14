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
import ballerina/oauth2;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.hubapi.com/marketing/v3/transactional" : "http://localhost:9090";

final string clientId = os:getEnv("HUBSPOT_CLIENT_ID");
final string clientSecret = os:getEnv("HUBSPOT_CLIENT_SECRET");
final string refreshToken = os:getEnv("HUBSPOT_REFRESH_TOKEN");

final Client hubSpotTransactional = check initClient();

isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, serviceUrl);
    }
    return check new ({
        auth: {
            token: "test-token"
        }
    }, serviceUrl);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testPostsendEmail() returns error? {
    record {|record {}...;|} customProperties = {
        "additionalProp1": {},
        "additionalProp2": {},
        "additionalProp3": {}
    };
    PublicSingleSendEmail message = {
        "cc": [
            "user1@abc.com"
        ],
        "sendId": "234",
        "bcc": [
            "user2@abc.com"
        ],
        "replyTo": [
            "string"
        ],
        "from": "string1",
        "to": "string2"
    };
    record {|string...;|} contactProperties = {
        "additionalProp1": "string",
        "additionalProp2": "string",
        "additionalProp3": "string"
    };

    PublicSingleSendRequestEgg payload = {customProperties, emailId: 0, message, contactProperties};
    EmailSendStatusView response = check hubSpotTransactional->/single\-email/send.post(payload, {});

    test:assertEquals(response.sendResult, "SENT", "Response send result is not as expected");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testPostresetPassword() returns error? {
    string tokenId = "234";
    SmtpApiTokenView response = check hubSpotTransactional->/smtp\-tokens/[tokenId]/password\-reset.post();

    test:assertEquals(response.id, "234", "Response id is not as expected");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetgetTokenById() returns error? {
    string tokenId = "123";
    SmtpApiTokenView response = check hubSpotTransactional->/smtp\-tokens/[tokenId].get({});

    test:assertEquals(response.id, "123", "Response id is not as expected");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testDeletearchiveToken() returns error? {
    string tokenId = "123";
    http:Response response = check hubSpotTransactional->/smtp\-tokens/[tokenId].delete({});

    test:assertEquals(response.statusCode, 204, "Failed to delete the token");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetgetTokensPage() returns error? {

    GetMarketingV3TransactionalSmtpTokens_gettokenspageQueries queries = {
        'limit: 2,
        emailCampaignId: "344",
        after: "0",
        campaignName: "Campaign2"
    };
    CollectionResponseSmtpApiTokenViewForwardPaging response = check hubSpotTransactional->/smtp\-tokens.get(queries = queries);
    test:assertEquals(response.results.length(), 2, "Response results length is not as expected");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testPostcreateToken() returns error? {
    SmtpApiTokenRequestEgg payload = {
        createContact: false,
        campaignName: "Campaign2"
    };
    SmtpApiTokenView response = check hubSpotTransactional->/smtp\-tokens.post(payload, {});

    test:assertEquals(response.campaignName, "Campaign2", "Response campaign name is not as expected");
}
