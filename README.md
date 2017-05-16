# 'Buildit' Alexa skill

This is an Alexa skill that spits out facts about Buildit

# Rationale

Alexa is awesome. It's the future. It's a technical challenge:

* Do not use Lambda (like most of the demos do), but rather host the skill's implementation on a server, forcing us to learn how to install certificates.
* Do not use JS (like most of the demos do), but rather use Ruby.
* TDD our way out of this, as most demos do not refer to command-line testing frameworks.
* Write an Alexa skill that's backed by a data store, and can handle conversations.

# Example usage

'Alexa, tell buildit to list people in the NY office'

# Set up

## Ruby stuff

* Install [bundler](http://bundler.io)

Run

```bash
bundle
```

## Running tests

# Automated unit and integration tests

```bash
rake    # => Will run both RSpec and Cucumber tests
```

# Manual integration tests

## Postman against localhost

Before installing certificates that are needed for real Alexa interactions, you may use [postman](https://www.getpostman.com) to simulate them, posting to localhost:3000.
To do this, simply run the rails app locally and use the example intent schema from postman:
```json
{
  "version": "1.0",
  "session": {
    "new": false,
    "sessionId": "amzn1.echo-api.session.abeee1a7-aee0-41e6-8192-e6faaed9f5ef",
    "application": {
      "applicationId": "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"
    },
    "attributes": {},
    "user": {
      "userId": "amzn1.account.AM3B227HF3FAM1B261HK7FFM3A2",
      "permissions": {
        "consentToken": null
      },
      "accessToken": null
    }
  },
  "context": {
    "System": {
      "application": {
        "applicationId": "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"
      },
      "user": {
        "userId": "amzn1.account.AM3B227HF3FAM1B261HK7FFM3A2",
        "permissions": {
          "consentToken": null
        },
        "accessToken": null
      },
      "device": {
        "deviceId": null,
        "supportedInterfaces": {
          "AudioPlayer": {}
        }
      },
      "apiEndpoint": "https://api.amazonalexa.com/"
    },
    "AudioPlayer": {
      "offsetInMilliseconds": 0,
      "playerActivity": "IDLE"
    }
  },
  "request": {
    "type": "IntentRequest",
    "requestId": "amzn1.echo-api.request.6919844a-733e-4e89-893a-fdcb77e2ef0d",
    "timestamp": "2017-05-14T12:41:46.788Z",
    "locale": "en-US",
    "intent": {
      "name": "hello",
      "slots": {}
    }
  }
}
```

## Amazon and _ngrok_ against localhost

You can test intents and their replies when Amazon against your local dev by using [ngrok](https://ngrok.com).

Run it in a shell and take note of the public DNS you get, for example:
```http://c68d7548.ngrok.io```. When you run the app locally, anything sent to that address will end up on your localhost:3000.

Install a self-signed certificate so that Amazon will route Alexa interactions to the _ngrok_ address. 
Once that is done, register the skill with Amazon, and test live by issuing Alexa requests.

### Installing a self-signed certificate

* Create a configuration file

```text
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
C = US
ST = $your-state$
L = $your-city$  
O = $your-organization$ 
CN = $your-skill-name$

[v3_req]
keyUsage = keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @subject_alternate_names

[subject_alternate_names]
DNS.1 = $ngrok-address$
```

Make sure to replace the keywords enclosed in '$' to have your own data.

* Create the certificate

```bash
genrsa 2048 > private-key.pem
openssl req -new -key private-key.pem -out csr.pem
openssl req -new -x509 -days 365 -key private-key.pem -config cert.cnf -out certificate.pem
```
Your server certificate is _certificate.pem_ and will be needed when you create the app. Copy the contents into the certificate text field in the portal.


## Register the skill with Amazon (dev version)

- Portal
- Questions
- Certificate
- Language selection
- Enable skill on device

## Responding to requests while running locally 

- ngrok
- run in debug mode

# Elastic Beanstalk command-line tool installation

```shell
brew update
brew install awsebcli
```

# Code of conduct

See file.

# License

Creative commons, see file.

# Support

* Repo owner or admin: itamar.hassin@wipro.com
