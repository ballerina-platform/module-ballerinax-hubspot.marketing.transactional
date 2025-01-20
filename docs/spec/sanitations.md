_Author_:  <!-- TODO: Add author name --> \
_Created_: <!-- TODO: Add date --> \
_Updated_: <!-- TODO: Add date --> \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot Transactional emails. 
The OpenAPI specification is obtained from [Marketing Transactional API](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/main/PublicApiSpecs/Marketing/Transactional%20Single%20Send/Rollouts/140892/v3/transactionalSingleSend.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. `date-time` type mentioned in `openapi.json` was changed to `datetime`.
2. Change the url property of the servers object:

    * Original: `https://api.hubapi.com`
    * Updated: `https://api.hubapi.com/marketing/v3/transactional`
    * Reason: This change is made to ensure that    all API paths are relative to the versioned base URL (marketing/v3/transactional), which improves the consistency and usability of the APIs.

3. Update API Paths:

    * Original: `/marketing/v3/transactional`
    * Updated: `/`
    * Reason: This modification simplifies the API paths, making them shorter and more readable. It also centralizes the versioning to the base URL, which is a common best practice.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
Note: The license year is hardcoded to 2024, change if necessary.