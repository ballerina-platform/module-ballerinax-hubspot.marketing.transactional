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

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.marketing.'transactional as hstransactional;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

public function main() returns error? {

    hstransactional:OAuth2RefreshTokenGrantConfig auth = {
        clientId,
        clientSecret,
        refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    };

    final hstransactional:Client hubSpotTransactional = check new ({auth});

    hstransactional:SmtpApiTokenRequestEgg payload = {
        createContact: true,
        campaignName: "Campaign1"
    };

    hstransactional:SmtpApiTokenView response1 = check hubSpotTransactional->/smtp\-tokens.post(payload);
    io:println(string `The created SMTP API Token has the id ${response1.id}`);

    string tokenId = response1.id;

    hstransactional:SmtpApiTokenView response2 = check hubSpotTransactional->/smtp\-tokens/[tokenId].get();
    io:println(string `The SMTP API Token with id ${tokenId} has the campaign name ${response2.campaignName}`);

    hstransactional:SmtpApiTokenView response3 = check hubSpotTransactional->/smtp\-tokens/[tokenId]/password\-reset.post();
    io:println(string `The password of the SMTP API Token with id ${response3.id} has been reset`);

}
