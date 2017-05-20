class LaunchRequest
  def respond
    output = AlexaRubykit::Response.new
    output.add_speech("Welcome to the Buildit app. Ask me stuff and I'll see if I can help.")
    output.build_response(false)
  end
end
