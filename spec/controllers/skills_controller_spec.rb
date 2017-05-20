require 'rails_helper'
require 'test_helpers'
require 'socket'

RSpec.describe SkillsController, type: :controller do

  # describe 'audio tests' do
  #   it 'responds to ListOffice' do
  #     Office.create [{ name: 'London' }, { name: 'Tel Aviv' }]
  #
  #     pid = play_audio 'spec/audio/list-office.m4a'
  #
  #     client, data = start_server
  #
  #     post :root, params: JSON.parse(data), format: :json
  #     result = !(response.body =~ /Our offices are in London/).nil?
  #
  #     reply client, 'The test ' + (result ? 'passed' : 'failed') + '. The result was ' + JSON.parse(response.body)['response']['outputSpeech']['text']
  #     expect(result).to be true
  #   end
  # end

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

      it 'reports a multiple offices' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        Office.create [{name: 'London'}, {name: 'Tel Aviv'}]
        post :root, params: request, format: :json
        expect(response.body).to match /Our offices are in London, and last but not least is the office in Tel Aviv./
      end
    end
  end

  describe 'Launch Request' do
    it 'responds correctly' do
      request = JSON.parse(File.read('spec/fixtures/launch_request.json'))
      post :root, params: request, format: :json
      expect(response.body).to match /Welcome to the Buildit app/
    end
  end
end
