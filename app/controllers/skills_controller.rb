class SkillsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def root
    case params['request']['type']
      when 'LaunchRequest'
        response = LaunchRequest.new.respond
      when 'IntentRequest'
        response = ApplicationHelper::IntentRequest.new.respond(params['request']['intent'], params['session'])
    end
    render json: response
  end
end
