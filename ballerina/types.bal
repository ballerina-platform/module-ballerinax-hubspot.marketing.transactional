// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

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

public type CollectionResponseSmtpApiTokenViewForwardPaging record {
    ForwardPaging paging?;
    SmtpApiTokenView[] results;
};

# A request to send a single transactional email asynchronously
public type PublicSingleSendRequestEgg record {
    # The customProperties field is a map of property values. Each property value contains a name and value property. Each property will be visible in the template under {{ custom.NAME }}.
    # Note: Custom properties do not currently support arrays. To provide a listing in an email, one workaround is to build an HTML list (either with tables or ul) and specify it as a custom property
    record {|record {}...;|} customProperties?;
    # The content ID for the transactional email, which can be found in email tool UI
    int:Signed32 emailId;
    PublicSingleSendEmail message;
    # The contactProperties field is a map of contact property values. Each contact property value contains a name and value property. Each property will get set on the contact record and will be visible in the template under {{ contact.NAME }}. Use these properties when you want to set a contact property while you’re sending the email. For example, when sending a reciept you may want to set a last_paid_date property, as the sending of the receipt will have information about the last payment
    record {|string...;|} contactProperties?;
};

# A SMTP API token provides both an ID and password that can be used to send email through the HubSpot SMTP API
public type SmtpApiTokenView record {
    # Timestamp generated when a token is created
    string createdAt;
    # Password used to log into the HubSpot SMTP server
    string password?;
    # Email address of the user that sent the token creation request
    string createdBy;
    # Indicates whether a contact should be created for email recipients
    boolean createContact;
    # User name to log into the HubSpot SMTP server
    string id;
    # Identifier assigned to the campaign provided in the token creation request
    string emailCampaignId;
    # A name for the campaign tied to the token
    string campaignName;
};

# A JSON object containing anything you want to override
public type PublicSingleSendEmail record {
    # List of email addresses to send as Cc
    string[] cc?;
    # ID for a particular send. No more than one email will be sent per sendId
    string sendId?;
    # List of email addresses to send as Bcc
    string[] bcc?;
    # List of Reply-To header values for the email
    string[] replyTo?;
    # The From header for the email
    string 'from?;
    # The recipient of the email
    string to;
};

# Describes the status of an email send request
public type EmailSendStatusView record {
    EventIdView eventId?;
    # Time when the send was completed
    string completedAt?;
    # Identifier used to query the status of the send
    string statusId;
    # Result of the send
    "SENT"|"IDEMPOTENT_IGNORE"|"QUEUED"|"IDEMPOTENT_FAIL"|"THROTTLED"|"EMAIL_DISABLED"|"PORTAL_SUSPENDED"|"INVALID_TO_ADDRESS"|"BLOCKED_DOMAIN"|"PREVIOUSLY_BOUNCED"|"EMAIL_UNCONFIRMED"|"PREVIOUS_SPAM"|"PREVIOUSLY_UNSUBSCRIBED_MESSAGE"|"PREVIOUSLY_UNSUBSCRIBED_PORTAL"|"INVALID_FROM_ADDRESS"|"CAMPAIGN_CANCELLED"|"VALIDATION_FAILED"|"MTA_IGNORE"|"BLOCKED_ADDRESS"|"PORTAL_OVER_LIMIT"|"PORTAL_EXPIRED"|"PORTAL_MISSING_MARKETING_SCOPE"|"MISSING_TEMPLATE_PROPERTIES"|"MISSING_REQUIRED_PARAMETER"|"PORTAL_AUTHENTICATION_FAILURE"|"MISSING_CONTENT"|"CORRUPT_INPUT"|"TEMPLATE_RENDER_EXCEPTION"|"GRAYMAIL_SUPPRESSED"|"UNCONFIGURED_SENDING_DOMAIN"|"UNDELIVERABLE"|"CANCELLED_ABUSE"|"QUARANTINED_ADDRESS"|"ADDRESS_ONLY_ACCEPTED_ON_PROD"|"PORTAL_NOT_AUTHORIZED_FOR_APPLICATION"|"ADDRESS_LIST_BOMBED"|"ADDRESS_OPTED_OUT"|"RECIPIENT_FATIGUE_SUPPRESSED"|"TOO_MANY_RECIPIENTS"|"PREVIOUSLY_UNSUBSCRIBED_BRAND"|"NON_MARKETABLE_CONTACT"|"PREVIOUSLY_UNSUBSCRIBED_BUSINESS_UNIT"|"GDPR_DOI_ENABLED" sendResult?;
    # Time when the send was requested
    string requestedAt?;
    # Time when the send began processing
    string startedAt?;
    # Status of the send request
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

# A request object to create a SMTP API token
public type SmtpApiTokenRequestEgg record {
    # Indicates whether a contact should be created for email recipients
    boolean createContact;
    # A name for the campaign tied to the SMTP API token
    string campaignName;
};

public type ForwardPaging record {
    NextPage next?;
};

# Represents the Queries record for the operation: get-/marketing/v3/transactional/smtp-tokens_getTokensPage
public type GetMarketingV3TransactionalSmtpTokensGetTokensPageQueries record {
    # Maximum number of tokens to return
    int:Signed32 'limit?;
    # Identifier assigned to the campaign provided during the token creation
    string emailCampaignId?;
    # Starting point to get the next set of results
    string after?;
    # A name for the campaign tied to the SMTP API token
    string campaignName?;
};

# The ID of a send event
public type EventIdView record {
    # Time of event creation
    string created;
    # Identifier of event
    string id;
};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.hubapi.com/oauth/v1/token";
|};

public type NextPage record {
    # 
    string link?;
    # 
    string after;
};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    string privateAppLegacy;
|};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Provides Auth configurations needed when communicating with a remote HTTP endpoint.
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig|ApiKeysConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};
