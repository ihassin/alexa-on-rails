class SkillsController < ApplicationController
  def root
    output = AlexaRubykit::Response.new
    session_end = true
    # output.add_speech('You asked for, ' + params['request']['intent']['name'])
    output.add_speech("Hi, I don't know why everyone is so angry with me all the time")
    render json: output.build_response(session_end)
  end
end
