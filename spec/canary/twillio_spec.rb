require 'rails_helper'
require 'twilio-ruby'

RSpec.describe 'Misc' do
  describe 'twillio', :canary do
    it 'sends SMS messages' do
      client = Twilio::REST::Client.new
      expect(client.messages.create(from: ENV['TWILLIO_ORIGIN'], to: ENV['TWILLIO_DEST'], body: 'Hi from RSpec')).not_to be nil
    end
  end
end
