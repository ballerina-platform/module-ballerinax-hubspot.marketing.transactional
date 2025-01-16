## Hubspot SMTP Token Manager

This use case demonstrates how the `hubspot.marketing.'transactional` API can be utilized create a SMTP API token and query using it's ID. 

## Prerequisites

### 1. Setup the Hubspot developer account

Refer to the [Setup guide](https://github.com/module-ballerinax-hubspot.marketing.transactional/tree/main/README.md) to obtain necessary credentials (client Id, client secret, Refresh tokens).

### 2. Configuration

Create a `Config.toml` file in the example's root directory and, provide your Hubspot account related configurations as follows:

```toml
clientId = "<Client ID>"
clientSecret = "<Client Secret>"
refreshToken = "<Access Token>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```