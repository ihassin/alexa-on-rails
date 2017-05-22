class LaunchRequest
  def respond
    output = AlexaRubykit::Response.new
    output.add_speech("Welcome to the Buildit app. Ask me to list our offices, who works where, and to find a vacant rooms.")
    output.build_response(false)
  end
end
