require 'rails_helper'

RSpec.describe 'ListOfficeIntent' do
  before :all do
    @intent_request = ListOfficeIntent.new
  end

  describe 'Intents' do
    it 'handles no offices' do
      expect(@intent_request.handle_request([])).to match /We don't have any offices/
    end

    it 'handles a single office' do
      expect(@intent_request.handle_request(['NY'])).to match /NY is the only office./
    end

    it 'handles multiple offices' do
      expect(@intent_request.handle_request(['NY', 'London'])).to match /Our offices are in NY, and last but not least is the office in London./
    end
  end

end
