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

```bash
cucumber
```

### Elastic Beanstalk command-line tool installation

```shell
brew update
brew install awsebcli
```

* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

## Contribution guidelines

* Writing tests
* Code review
* Other guidelines

## Who do I talk to? ###

* Repo owner or admin: itamar.hassin@wipro.com
* Other community or team contact
