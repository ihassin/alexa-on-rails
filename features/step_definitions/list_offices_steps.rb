require_relative '../../lib/test_helpers.rb'

Given(/^we have offices "([^"]*)" and "([^"]*)"$/) do |office1, office2|
  Office.create [{ name: @office1 = office1 }, { name: @office2 = office2 }]
end

When(/^I ask Alexa to list the offices$/) do
  play_audio 'spec/audio/list-office.m4a'
end

Then(/^it lists them correctly$/) do
  client, data = start_server

  post '/', JSON.parse(data), format: :json
  result = !(last_response =~ /Our offices are in #{@office1}/).nil?
  reply client, 'The test ' + (result ? 'passed' : 'failed')
  expect(result).to be true
end
