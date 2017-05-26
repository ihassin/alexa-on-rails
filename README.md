# 'Buildit' Alexa skill

This is an Alexa skill that spits out facts about Buildit

# Rationale

Alexa is awesome. It's the future. It's a technical challenge:

* To not use Lambda (like most of the demos do), but rather host the skill's implementation on a server, forcing us to learn how to install certificates.
* To not use JS (like most of the demos do), but rather use Ruby/Rails.
* To find a way to TDD our way out of this, as most demos do not refer to command-line testing frameworks.
* To write an Alexa skill that's backed by a data store
* To be able to handle conversations.

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
rake     # => Will run RSpec unit tests (integration tests are excluded)
```

# Manual integration tests

## Postman against localhost

Before installing certificates that are needed for real Alexa interactions, you may use [postman](https://www.getpostman.com) to simulate them, posting to localhost:3000.

## Amazon and _ngrok_ against localhost

You can test intents and their replies when Amazon against your local dev by using [ngrok](https://ngrok.com).

Run it in a shell and take note of the public DNS you get, for example:
```http://c68d7548.ngrok.io```.

When you run the app locally, anything sent to that address will end up on your localhost:3000.

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
openssl genrsa 2048 > private-key.pem
openssl req -new -x509 -days 365 -key private-key.pem -config cert.cnf -out certificate.pem
```
Your server certificate is _certificate.pem_ and will be needed when you create the app. Copy the contents into the certificate text field in the portal.

## Register the skill with Amazon (dev version)

- Enable for testing
It's not very intuitive, but the progress-UI does not change when you select 'enable for testing'. Effectively, you can skip the production version questions if you're in testing mode. 

- Certificate
Paste the contents of ```certificate.pem``` in the text box.

- Language selection
Note that Alexa classifies English US and UK as two different languages. So if you program for US, but Alexa is set to UK, your skill will not be called.

- Enable skill on device
Use the Alexa app on your phone or Alexa device to enable the skill.

## Responding to requests while running locally 

- Run ```ngrok``` to forward traffic to the app (assuming it's in /usr/local/bin)

```bash
/usr/local/bin/ngrok http -hostname=alexa01.ngrok.io 3000
```
- Run Rails in debug mode:
```bash
rails s
```
- Go to the Alexa dev page to the 'test' section and make sure your app gets called.
You can also see ```ngrok``` status at ```http://localhost 4040```

# Elastic Beanstalk command-line tool installation

```shell
brew update
brew install awsebcli
```

# Code of conduct

See [file](https://bitbucket.org/digitalrigbitbucketteam/buildit-alexa-skill/src/b2d808302cb3ac43969edff5721486f6341dcd5d/code-of-conduct.md?at=master&fileviewer=file-view-default).

# License

Creative commons, see [file](https://bitbucket.org/digitalrigbitbucketteam/buildit-alexa-skill/src/b2d808302cb3ac43969edff5721486f6341dcd5d/license.md?at=master&fileviewer=file-view-default).

# Support

* Repo owner or admin: itamar.hassin@wipro.com
