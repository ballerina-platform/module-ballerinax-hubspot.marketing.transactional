# Examples

The `ballerinax/hubspot.marketing.'transactional` connector provides practical examples illustrating usage in various scenarios.

1. [Manage Tokens](https://github.com/module-ballerinax-hubspot.marketing.transactional/tree/main/examples/manage-tokens) - see how the Hubspot API can be used to create SMTP API token and query it and resetting the password of an existing token.

## Prerequisites


1. Generate hubspot credentials to authenticate the connector as described in the [setup guide](https://github.com/module-ballerinax-hubspot.marketing.transactional/tree/main/README.md).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml `file should look:
    ```toml
    clientId = "<Client ID>"
    clientSecret = "<Client Secret>"
    refreshToken = "<Access Token>"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
