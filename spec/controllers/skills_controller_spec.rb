require 'rails_helper'

RSpec.describe SkillsController, type: :controller do

  describe 'Office information' do
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
      ['London', 'Tel Aviv'].each do |office|
        Office.create name: office
      end
      post :root, params: request, format: :json
      expect(response.body).to match /Our offices are in London, and last but not least, is the office in Tel Aviv./
    end
  end
end
