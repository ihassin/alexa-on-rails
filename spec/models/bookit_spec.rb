require 'rails_helper'

RSpec.describe 'Bookit' do
  before :all do
    @intent_request = IntentRequest.new
  end

  describe 'BookitRequests' do
    it 'handles no rooms' do
      expect(@intent_request.handle_bookit_request([], [])).to match /There are no rooms/
    end

    it 'handles no vacancies' do
      expect(@intent_request.handle_bookit_request(['Red'], ['Red'])).to match /There are no vacant rooms/
    end

    it 'handles vacancies when one is vacant' do
      expect(@intent_request.handle_bookit_request(['Red', 'Green'], ['Red'])).to match /Of 2, 1 is available. Green is vacant for those dates./
    end

    it 'handles vacancies when none are vacant' do
      expect(@intent_request.handle_bookit_request(['Red', 'Green'], ['Red', 'Green'])).to match /There are no vacant rooms for those dates./
    end

    it 'handles vacancies when several are vacant' do
      expect(@intent_request.handle_bookit_request(['Yellow', 'Red', 'Green', 'Blue'], ['Red', 'Blue'])).to match /Of 4, 2 are available. Green and Yellow are vacant for those dates./
    end

    it 'handles vacancies when all are vacant' do
      expect(@intent_request.handle_bookit_request(['Red'], [])).to match /All rooms seem to be vacant/
    end

  end
end
