module ApplicationHelper
  class IntentRequest
    def respond intent_request
      intent_name = intent_request['name']

      Rails.logger.debug { "IntentRequest: #{intent_request.to_json}" }

      case intent_name
        when 'ListOffice'
          speech = ListOfficeIntent.new.prepare_request
        when 'OfficeWorkers'
          speech = ListWorkersIntent.new.prepare_request(intent_request)
        when 'OfficeQuery'
          speech = OfficeQueryIntent.new.prepare_request(intent_request)
        when 'Bookit'
          speech = BookitIntent.new.prepare_request(intent_request)
        when 'AMAZON.StopIntent'
          speech = 'Peace, out.'
        else
          speech = 'I am going to ignore that.'
      end

      output = AlexaRubykit::Response.new
      output.add_speech(speech)
      output.build_response(true)
    end

  end

end
