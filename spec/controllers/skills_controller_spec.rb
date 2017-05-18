require 'rails_helper'

RSpec.describe SkillsController, type: :controller do

  describe 'Hello intent request' do
    it 'echos the intent' do
      request = JSON.parse(File.read('spec/fixtures/hello_intent_request.json'))
      post :root, params: request, format: :json
      expect(response.body).to match /is so angry/
    end
  end

end
