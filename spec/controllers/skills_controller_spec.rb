require 'rails_helper'
require 'socket'

def start_server
  server = TCPServer.new('localhost', 3000)
  client = server.accept
  method, path = client.gets.split

  # Collect HTTP headers
  headers = {}
  while line = client.gets.split(' ', 2)
    break if line[0] == ''
    headers[line[0].chop] = line[1].strip
  end
  # Read the POST data as specified in the header
  data = client.read(headers['Content-Length'].to_i)
  return client, data
end

def reply(socket, result)
  output = AlexaRubykit::Response.new
  # output.add_speech('Thank you for testing. The test ' + result)
  output.add_speech(result)
  output.build_response(true)
  response = output.to_json + "\n"

  socket.print "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: application/json\r\n" +
                   "Content-Length: #{response.bytesize}\r\n" +
                   "Connection: close\r\n"

  socket.print "\r\n"
  socket.print response
  socket.close
end

def play_audio file
  fork { exec 'afplay ' + file }
end

RSpec.describe SkillsController, type: :controller do

  describe 'audio tests' do
    it 'responds to ListOffice' do
      Office.create [{ name: 'London' }, { name: 'Tel Aviv' }]

      pid = play_audio 'spec/audio/list-office.m4a'

      client, data = start_server

      post :root, params: JSON.parse(data), format: :json
      result = !(response.body =~ /Our offices are in London/).nil?

      reply client, 'The test ' + (result ? 'passed' : 'failed') + '. The result was ' + JSON.parse(response.body)['response']['outputSpeech']['text']
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

      it 'reports a multiple offices' do
        request = JSON.parse(File.read('spec/fixtures/list_offices.json'))
        Office.create [{name: 'London'}, {name: 'Tel Aviv'}]
        post :root, params: request, format: :json
        expect(response.body).to match /Our offices are in London, and last but not least, is the office in Tel Aviv./
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
