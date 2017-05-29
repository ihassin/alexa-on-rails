require 'rails_helper'

RSpec.describe Session do
  describe 'Logging' do
    it 'logs session information', :integration do
      intent_info = JSON.parse(File.read('spec/fixtures/list_offices.json'))
      session_id = intent_info['session']['sessionId']
      user_id = intent_info['session']['user']['userId']
      expect(AlexaIntent.new.log_session intent_info['session']).to eq 'amzn1.echo-api.session.03a4c538-d5da-4248-acd3-0845c44b3654'
    end

    it 'logs session information once per user', :integration do
      intent_info = JSON.parse(File.read('spec/fixtures/list_offices.json'))

      session_id = intent_info['session']['sessionId']
      user_id = intent_info['session']['user']['userId']

      AlexaIntent.new.log_session intent_info['session']
      db_user = User.first.id

      AlexaIntent.new.log_session intent_info['session']

      expect(User.where('user_id = ?', user_id).all.count).to eq 1
      expect(Session.where('user_id = ?', db_user).count).to eq 1
    end

    it 'logs multiple session information per user', :integration do
      intent_info = JSON.parse(File.read('spec/fixtures/list_offices.json'))

      session_id = intent_info['session']['sessionId']
      user_id = intent_info['session']['user']['userId']

      AlexaIntent.new.log_session intent_info['session']
      db_user = User.first.id

      intent_info['session']['sessionId'] = 'a'

      AlexaIntent.new.log_session intent_info['session']

      expect(User.where('user_id = ?', user_id).all.count).to eq 1
      expect(Session.where('user_id = ?', db_user).count).to eq 2
    end
  end
end
