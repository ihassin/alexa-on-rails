require 'rails_helper'
require 'test_helpers'

RSpec.describe SkillsController, type: :controller do

  describe 'audio tests', :audio do
    it 'responds to ListOffice intent' do
      london = 'Paris'
      aviv = 'Tel Aviv'

      Office.create [{ name: london }, { name: aviv }]

      pid = play_audio 'spec/fixtures/list-office.m4a'

      client, data = start_server

      post :root, params: JSON.parse(data), format: :json
      result = (response.body =~ /(?=#{london})(?=.*#{aviv})/) > 0

      reply client, 'The list offices intent test ' + (result ? 'passed' : 'failed')
      expect(result).to be true
    end

  end

  describe 'Intents' do
    describe 'Office IntentRequest' do
      it 'reports no offices' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        post :root, params: request, format: :json
        expect(response.body).to match /We don't have any offices/
      end

      it 'reports a single office' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        Office.create name:'London'
        post :root, params: request, format: :json
        expect(response.body).to match /London is the only office/
      end

      it 'reports multiple offices' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        Office.create [{name: 'London'}, {name: 'Tel Aviv'}]
        post :root, params: request, format: :json
        expect(response.body).to match /Our offices are in London, and last but not least is the office in Tel Aviv./
      end
    end
  end

  describe 'Launch request' do
    it 'responds correctly' do
      request = JSON.parse(File.read('spec/fixtures/launch_request.json'))
      post :root, params: request, format: :json
      expect(response.body).to match /Welcome to the Buildit app/
    end
  end
end
