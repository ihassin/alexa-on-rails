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
      expect(@intent_request.handle_list_office_request(['NY', 'London'])).to match /Our offices are in NY, and last but not least, is the office in London./
    end
  end

end
