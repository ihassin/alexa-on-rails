require 'rails_helper'

RSpec.describe Office, type: :model do
  it 'build an intent schema' do
    intent_schema = Alexa.new.build_intent
    expect(intent_schema).to match /hi/
  end
end
