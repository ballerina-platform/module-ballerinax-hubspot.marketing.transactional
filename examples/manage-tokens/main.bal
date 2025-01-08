import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.marketing.'transactional as hstransactional;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

//auth confguration for hubspot
hstransactional:OAuth2RefreshTokenGrantConfig auth = {
    clientId: clientId,
    clientSecret: clientSecret,
    refreshToken: refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

hstransactional:ConnectionConfig config = {auth: auth};
//authorized http client to access hubspot
final hstransactional:Client base_client = check new hstransactional:Client(config);

public function main() returns error? {

    hstransactional:SmtpApiTokenRequestEgg payload = {
        createContact: true,
        campaignName: "Campaign1"
    };

    hstransactional:SmtpApiTokenView response = check base_client->/smtp\-tokens.post(payload, {});

    io:println("The created SMTP API Token has the id " + response.id);

    string tokenId = response.id;
    hstransactional:SmtpApiTokenView out = check base_client->/smtp\-tokens/[tokenId].get({});

    io:println("The SMTP API Token with id " + tokenId + " has the campaign name " + out.campaignName);
    return;
}
