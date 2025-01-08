// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
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
import ballerina/io;
import ballerina/oauth2;
import ballerina/http;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable boolean isServerLocal = true;

OAuth2RefreshTokenGrantConfig auth = {
       clientId: clientId,
       clientSecret: clientSecret,
       refreshToken: refreshToken,
       credentialBearer: oauth2:POST_BODY_BEARER // this line should be added in to when you are going to create auth object.
   };


ConnectionConfig config = {auth : auth};
final string serviceURL = isServerLocal ? "http://localhost:8080" : "https://api.hubapi.com/marketing/v3/transactional";
final Client base_client = check new Client(config, serviceURL);

@test:Config {
    enable: false
}
isolated function  testPostsendEmail() returns error?{
    record {|record {}...;|}  customProperties = {
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

    PublicSingleSendRequestEgg payload ={ customProperties, emailId: 0, message, contactProperties };
    EmailSendStatusView response = check base_client->/single\-email/send.post(payload,{});
    if response is EmailSendStatusView{
        test:assertEquals(response.sendResult, "SENT" , "Response send result is not as expected");
    }
}

@test:Config {
    enable: false
}
isolated function  testPostresetPassword() returns error?{
    string tokenId="123";
    SmtpApiTokenView response = check base_client->/smtp\-tokens/[tokenId]/password\-reset.post();
    if response is SmtpApiTokenView{
        test:assertEquals(response.id, "123" , "Response id is not as expected");
    }
    io:println(response);
}

@test:Config {
    enable: false
}
isolated function  testGetgetTokenById() returns error?{
    string tokenId="123";
    SmtpApiTokenView response = check base_client->/smtp\-tokens/[tokenId].get({});
    if response is SmtpApiTokenView{
        test:assertEquals(response.id, "123" , "Response id is not as expected");
    }
}

@test:Config {
    enable: false
}
isolated function  testDeletearchiveToken() returns error?{
    string tokenId="123";
    http:Response response = check base_client->/smtp\-tokens/[tokenId].delete({});
    if response is http:Response{
        test:assertEquals(response.statusCode, 200 , "Failed to delete the token");
    }
}

@test:Config {
    enable: false
}
isolated function  testGetgetTokensPage() returns error?{
    int:Signed32 'limit = 3;
    string emailCampaignId = "344";
    string after="0";
    string campaignName="Campaign2";

    GetMarketingV3TransactionalSmtpTokens_gettokenspageQueries queries = {'limit, emailCampaignId, after, campaignName};
    CollectionResponseSmtpApiTokenViewForwardPaging response = check base_client->/smtp\-tokens.get({},queries); 
    if response is CollectionResponseSmtpApiTokenViewForwardPaging{
        test:assertEquals(response.results.length(), 3 , "Response results length is not as expected");
    } 
}

@test:Config {
    enable: true
}
isolated function  testPostcreateToken() returns error?{
    SmtpApiTokenRequestEgg payload = {
        createContact: true,
        campaignName: "Campaign2"
    };
    SmtpApiTokenView response = check base_client->/smtp\-tokens.post(payload,{});
    if response is SmtpApiTokenView{
        test:assertEquals(response.campaignName,"Camapaign2", "Response campaign name is not as expected");
    }
}
