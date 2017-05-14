# 'Buildit' Alexa skill

This is an Alexa skill that spits out facts about Buildit

## What is this repository for?

It's a technical challenge:

* Write an Alexa skill that's backed by a data store, and can handle conversations.
* Do not use Lambda (like most of the demos do), but rather host the skill's implementation on a server, forcing us to learn how to install certificates.
* Do not use JS (like most of the demos do), but rather use Ruby.
* TDD our way out of this, as most demos do not refer to command-line testing frameworks.

## Example usage

'Alexa, tell buildit to list people in the NY office'

## How do I get set up?

### Ruby stuff

* Install [bundler](http://bundler.io)

Run

```bash
bundle
```

### Running tests

## Automated unit and integration tests

```bash
rake    # => Will run both RSpec and Cucumber tests
```

## Manual integration tests

You can test the intents and their replies using Amazon against your local dev without having to deploy the app by using [ngrok](https://ngrok.com).
Run it in a shell and take note of the public DNS you get, for example: 
```http://c68d7548.ngrok.io```

Anything sent to that address will end up on your localhost:3000. This app, when run locally, will pick up the requests sent there.
Before installing certificates that are needed for real Alexa interactions, you may use [postman](https://www.getpostman.com) to simulate them, posting to the _ngrok_ address.

### Elastic Beanstalk command-line tool installation

```shell
brew update
brew install awsebcli
```

* Configuration
* Dependencies
* Database configuration
* Deployment instructions

## Contribution guidelines

* Writing tests
* Code review
* Other guidelines

## Who do I talk to? ###

* Repo owner or admin: itamar.hassin@wipro.com
* Other community or team contact
