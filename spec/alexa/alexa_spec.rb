require 'rails_helper'

RSpec.describe :Alexa do
  before :all do
    @alexa = Alexa.new
  end

  describe 'Intent schema' do
    it 'creates the schema' do
      @alexa.build_intent_schema
    end
  end

end
