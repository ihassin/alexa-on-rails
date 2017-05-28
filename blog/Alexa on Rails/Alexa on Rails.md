# Introduction

Alexa is awesome and I think that conversational software is the future. This post documents what I set myself as a technical learning challenge:

* Host the skill locally, to allow a fast development feedback cycle prior to pushing code
* To find a way to automated tests (unit, functional and end-to-end), as most demos refer to manual testing.
* To not use JS (like most of the demos do), but rather use Ruby/Rails.
* To write an Alexa skill that's backed by a data store
* To be able to handle conversations.

The way Alexa services interact with apps is the following:

```sequence
User->Echo: "Alexa, ..."
Note right of Echo: Wakes on 'Alexa'
Echo->Amazon: Streams data spoken
Amazon->Rails: OfficeIntent
Rails->SkillsController: POST
SkillsController->Amazon: reply (text)
Amazon->Echo: reply (voice)
Echo->User: Speaks
```

# The skill

The skill is a data retrieval one, giving information about the company’s offices and the workers there.

## Alexa, Rails, git, ngrok and an Amazon account

I bought a [dot](https://www.amazon.com/Amazon-Echo-Dot-Portable-Bluetooth-Speaker-with-Alexa-Black/dp/B01DFKC2SO/ref=ice_ac_b_dpb?ie=UTF8&qid=1495913856&sr=8-1&keywords=dot) and set up an [Amazon account](https://developer.amazon.com/edw/home.html#/skills) to register the skill on.

Install [Rails](http://rubyonrails.org/) and [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for your OS. You’ll also need a data-store, easily using sqlite, or mysql gems.

[ngrok](https://ngrok.com/) is a nifty tool that will tunnle Alexa calls in to our local server.

## Let’s get started

### Get the code

Fork or clone [the repo](https://bitbucket.org/ihassin/alexa-on-rails) for a head-start, or read along taking only pieces you need from this post.

### Set up the app

* Setting some environment variables

The database connection use the following environment variables:

```bash
export ALEXA_DB_USERNAME=<insert your db username here>
export ALEXA_DB_PASSWORD=<insert your db password here>
```

* Setting up the database

```sh
bundle
rake db:create db:migrate db:seed spec
```

This will create and setup the database tables, seed the development tables and run the unit and integration tests.

* Running tests

```sh
rake
```

Will run all tests excluding the audio tests, which I’ll describe below. Make sure all tests pass.

## Connecting to the real thing

When a user invokes your skill, Amazon will route requests to an endpoint listed on the Alexa site. In order for this to function, you must first configure the skill there. It’s straightforward, but must be manually uploaded to the skill’s configuration page on Amazon’s site.

### Intent schema

This is where you define the intents the user can express to your skill. I think of ‘intents’ as the skill’s ‘methods’, if you think of the skill as an object.

Here is our skill’s example:

```sh
{
  "intents": [
    {
      "intent": "AMAZON.StopIntent"
    },
    {
      "slots": [
        {
          "name": "StartDate",
          "type": "AMAZON.DATE"
        },
        {
          "name": "EndDate",
          "type": "AMAZON.DATE"
        }
      ],
      "intent": "Bookit"
    },
    {
      "intent": "ListOffice"
    },
    {
      "slots": [
        {
          "name": "Office",
          "type": "LIST_OF_OFFICES"
        }
      ],
      "intent": "OfficeQuery"
    },
    {
      "slots": [
        {
          "name": "Office",
          "type": "LIST_OF_OFFICES"
        },
        {
          "name": "Staff",
          "type": "LIST_OF_STAFF"
        }
      ],
      "intent": "OfficeWorkers"
    }
  ]
}
```

### Utterances

Here are those we’re using:

```sh
Bookit for vacant rooms between {StartDate} and {EndDate}
Bookit find a room for {StartDate}
ListOffice what offices do we have
ListOffice what offices we have
ListOffice what offices there are
ListOffice which offices do we have
ListOffice which offices we have
ListOffice which offices there are
ListOffice to list the offices
ListOffice to list our offices
ListOffice to list the Buildit offices
ListOffice to tell me which offices we have
ListOffice to tell me our offices
ListOffice to tell me which Buildit offices there are
OfficeQuery do we have an office in {Office}
OfficeQuery is there an office in {Office}
OfficeQuery Does the {Office} office exist
OfficeQuery if the {Office} office exists
OfficeWorkers to list the {Office} {Staff}
OfficeWorkers to list the {Staff} from {Office}
OfficeWorkers to list the {Staff} from the {Office} office
OfficeWorkers who works in {Office}
OfficeWorkers who work in {Office}
OfficeWorkers {Staff} who are from {Office}
OfficeWorkers who is from the {Office} office
OfficeWorkers who the {Staff} from {Office} are
```

### Slot types

Here are the slot types for our skill:

![Google ChromeScreenSnapz004.png](resources/FCFC888D871961497AADF653BE2C6C7C.png)

Now that you have configured the skill’s interfaces, we now need to route communications from Amazon to our local server running Rails as we develop and debug. This is easily done using [ngrok](https://ngrok.com/), explained below.

### ngrok

ngrok is a service, with a free tier, that will redirect traffic from outside your home/office’s firewall into your network. Once configured, it will route traffic from Amazon to our http://localhost:3000, invaluable for our aspired fast development cycle.

Run it using:

```sh
ngrok http -hostname=endpoint.ngrok.io 3000
```

Your configuration may vary, depending on whether you are paying customer or not, so change ‘endpoint’ accordingly.

You’ll see something like this once you run it:

![TerminalScreenSnapz001.png](resources/446D63467E6924B84769949C9F9F818B.png)

Add your endpoint to Amazon’s skill page under configuration:

![Google ChromeScreenSnapz006.png](resources/D6CF60A9FF45A559E590CB2D90226D86.png)

### Generating a certificate

Once you’ve settled on the endpoint URL, you’ll need to create or reuse a certificate for Amazon to use when communicating with your server process.

```sh
genrsa 2048 > private-key.pem
openssl req -new -key private-key.pem -out csr.pem
openssl req -new -x509 -days 365 -key private-key.pem -config cert.cnf -out certificate.pem
```

Copy the the contents of ‘certificate.pem’ to the skill’s page on Amazon:

![Google ChromeScreenSnapz005.png](resources/6EEDBC6F724F544D7385E3273E79A05F.png)

Last, but not least, toggle the test switch to ‘on’, otherwise Amazon will think you’re trying to publish the skill on their Skills store:

![Google ChromeScreenSnapz007.png](resources/80281B8C59BCAF08D7FC0A1E0D6C308D.png)

Last but not least, enable the skill on your iPhone or Android by launching the Alexa app and verifying that the skill exists in ‘Your skills’ tab.

Amazon recap
------------

We uploaded the skill info, including:

* The Interaction model, uploading the 'intent schema’, ‘Custom slot types’, and ‘Sample utterances’.
* Configured the end-point
* Uploaded the SSL cert
* Enabled the test flag
* Verified that the skill is enabled by using your Alexa app on your mobile device

The moment we’ve been waiting for
---------------------------------

Run your rails app:

```sh
rails s
```

Run ngrok:

```sh
ngrok http -hostname=alexa01.ngrok.io 3000
```

Say something to Alexa:

```sh
Alexa, tell Buildit to list the offices
```

If all goes well, you should:

- See the request being logged in the ngrok terminal (telling you that Amazon connected and passed the request to it)

- See that the rails controller got the request by looking at the logs

- Hear the response from your Alexa device

*If there was a problem at this stage, please contact me so I can improve the instructions.*

# Code walkthrough

Route to a single skills controller:

```ruby
Rails.application.routes.draw do
  # Amazon comes in with a post request
  post '/' => 'skills#root', :as => :root
end
```

Set up that controller:

```ruby
class SkillsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def root
    case params['request']['type']
      when 'LaunchRequest'
        response = LaunchRequest.new.respond
      when 'IntentRequest'
        response = IntentRequest.new.respond(params['request']['intent'])
    end
    render json: response
  end
end
```

Handle the requests:

```ruby
  def respond intent_request
    intent_name = intent_request['name']

    Rails.logger.debug { "IntentRequest: #{intent_request.to_json}" }

    case intent_name
      when 'ListOffice'
        speech = prepare_list_office_request
      when 'OfficeWorkers'
        speech = prepare_office_workers_request(intent_request)
      when 'OfficeQuery'
        speech = prepare_office_query_request(intent_request)
      when 'Bookit'
        speech = prepare_bookit_request(intent_request)
      when 'AMAZON.StopIntent'
        speech = 'Peace, out.'
      else
        speech = 'I am going to ignore that.'
    end

    output = AlexaRubykit::Response.new
    output.add_speech(speech)
    output.build_response(true)
  end
```

# Test walkthrough

## Unit tests

Really fast, not touching any Alexa or controller code, just making sure that the methods create the correct responses:

```ruby
require 'rails_helper'

RSpec.describe 'Office' do
  before :all do
    @intent_request = IntentRequest.new
  end
  describe 'Intents' do
    it 'handles no offices' do
      expect(@intent_request.handle_list_office_request([])).to match /We don't have any offices/
    end

    it 'handles a single office' do
      expect(@intent_request.handle_list_office_request(['NY'])).to match /NY is the only office./
    end

    it 'handles multiple offices' do
      expect(@intent_request.handle_list_office_request(['NY', 'London'])).to match /Our offices are in NY, and last but not least is the office in London./
    end
  end
end
```

## Integration tests

Mocking out Alexa calls, ensure that the json coming in and out is correct:

```ruby
  describe 'Intents' do
    describe 'Office IntentRequest' do
      it 'reports no offices' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        post :root, params: request, format: :json
        expect(response.body).to match /We don't have any offices/
      end

      it 'reports a single office' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        Office.create name:'London'
        post :root, params: request, format: :json
        expect(response.body).to match /London is the only office/
      end

      it 'reports multiple offices' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        Office.create [{name: 'London'}, {name: 'Tel Aviv'}]
        post :root, params: request, format: :json
        expect(response.body).to match /Our offices are in London, and last but not least is the office in Tel Aviv./
      end
    end
  end
```

# Audio tests

I was keen on finding a way to simulate what would otherwise be an end-to-end user-acceptance test, like a Selenium session for a web-based app.

The audio test I came up with has the following flow:

```ruby
  describe 'audio tests', :audio do
    it 'responds to ListOffice intent' do
      london = 'Paris'
      aviv = 'Tel Aviv'

      Office.create [{ name: london }, { name: aviv }]

      pid = play_audio 'spec/fixtures/list-office.m4a'

      client, data = start_server

      post :root, params: JSON.parse(data), format: :json
      result = (response.body =~ /(?=#{london})(?=.*#{aviv})/) > 0

      reply client, 'The list offices intent test ' + (result ? 'passed' : 'failed')
      expect(result).to be true
    end

  end
```

Line 6: Creates some offices.

Line 8: Plays an audio file that asks Alexa to list the offices

Line 10: Starts an HTTP server listening on port 80\. Make sure that rails is not running, but keep ngrok up to direct traffic to the test.

Line 12: Will direct the intent request from Alexa to the controller

Line 13: Makes sure that both office names are present in the response

Line 15: Replaces the response that would have been sent back to Alexa with a curt message about the test passing or not.

Line 16: Relays the test status back to RSpec for auditing.

*This is as close as I got to an end-to-end test (audio and controller). Please let me know if you have other ways of achieving the same!*

# Conclusion

What was technically done here?

* We registered an Alexa skill
* We have a mechanism to direct traffic to our server
* We have a mechanism to unit-test, integration-test and acceptance-test our skill
* We have a mechanism that allows for a fast development cycle, running the skill locally till we’re ready to deploy it publically.

My main learning, however, was not a technical one (despite my thinking that the audio test is nifty!). Being an advocate for TDD and BDD, I realise that now there’s a new way of thinking about intents, whether the app is a voice-enabled one or not.

We may call it CDD, being Conversation Driven Development.

The classic “As a..”, “I want to…”, “So that…” manner of describing intent seems so *static* compared to ***imagining a conversation with your product***, whether it’s voice-enabled or not. In our case, try to imagine what a conversation with an office application would be like?

“Alexa, walk me through onboarding”. Through booking time, booking conference rooms, asking where office-mates are, what everyone is working on etc.

If the app happens to be a voice-enabled one, just make audio recordings of the prompts, and employ TDD off those. If it’s a classic app, use those conversations to create BDD scripts to help you implement the intents.


