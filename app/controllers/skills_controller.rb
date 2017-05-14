class SkillsController < ApplicationController
  def root
    output = AlexaRubykit::Response.new
    session_end = true
    output.add_speech('You asked for, ' + params['request']['intent']['name'])
    render json: output.build_response(session_end)
  end
end
