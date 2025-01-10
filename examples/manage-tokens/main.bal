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
        clientId: clientId,
        clientSecret: clientSecret,
        refreshToken: refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    };

    final hstransactional:Client hubSpotTransactional = check new ({auth});

    hstransactional:SmtpApiTokenRequestEgg payload = {
        createContact: true,
        campaignName: "Campaign1"
    };

    hstransactional:SmtpApiTokenView response = check hubSpotTransactional->/smtp\-tokens.post(payload, {});

    io:println(string `The created SMTP API Token has the id ${response.id}`);

    string tokenId = response.id;
    hstransactional:SmtpApiTokenView out = check hubSpotTransactional->/smtp\-tokens/[tokenId].get({});

    io:println(string `The SMTP API Token with id ${tokenId} has the campaign name ${out.campaignName}`);
}
