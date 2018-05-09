require 'rails_helper'

RSpec.describe 'DashboardIntent' do
  before :all do
    @intent_request = DashboardQueryIntent.new
  end

  describe 'Intents' do
    it 'handles no tasks' do
      expect(@intent_request.handle_request([])).to match /We're not working on any tasks/
    end

    it 'handles a single task' do
      expect(@intent_request.handle_request(['Write blog'])).to match /is the only task/
    end

  end

end
