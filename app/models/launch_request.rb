class LaunchRequest
  def init params
    output = AlexaRubykit::Response.new
    output.add_speech("Hi from the Buildit app. Ask me stuff and I'll see if I can help.")
    output.build_response(false)
  end
end
