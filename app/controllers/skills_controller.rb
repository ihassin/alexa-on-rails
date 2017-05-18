class SkillsController < ApplicationController
  def root
    case params['request']['type']
      when 'LaunchRequest'
        response = LaunchRequest.new.init(params)
      when 'IntentRequest'
        response = IntentRequest.new.init(params)
    end
    render json: response
  end
end
