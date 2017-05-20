require 'rails_helper'

RSpec.describe 'Worker' do
  before :all do
    @intent_request = IntentRequest.new
  end

  describe 'Intents' do
    it 'ignores a missing office-name' do
      expect(@intent_request.handle_office_workers_request(nil, nil, nil)).to match /I'm not sure/
      expect(@intent_request.handle_office_workers_request('', nil, nil)).to match /I'm not sure/
    end

    it 'handles no workers' do
      expect(@intent_request.handle_office_workers_request('Siberia', nil, nil)).to match /There's no one/
    end

    it 'handles a single worker' do
      mock_office = double(Office)
      expect(@intent_request.handle_office_workers_request('Siberia', mock_office, ['Andy'])).to match /is the only person/
    end

    it 'handles multiple workers' do
      mock_office = double(Office)
      expect(@intent_request.handle_office_workers_request('Siberia', mock_office, ['Andy', 'Hap'])).to match /Our people in/
    end
  end

end
