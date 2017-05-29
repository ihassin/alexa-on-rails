require 'rails_helper'

RSpec.describe SkillsController, :integration, type: :controller do

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
