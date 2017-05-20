def play_audio file
  fork { exec 'afplay ' + file }
end

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
