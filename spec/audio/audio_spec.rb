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

end
