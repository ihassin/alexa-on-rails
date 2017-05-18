class IntentRequest
  def init params
    output = AlexaRubykit::Response.new

    request = params['request']
    intent_request = request['intent']
    intent_name = intent_request['name']

    case intent_name
      when 'ListOffice'
        speech = handle_list_office_request(intent_request)
      when 'OfficeWorkers'
        speech = handle_office_workers_request(intent_request)
      when 'OfficeQuery'
        speech = handle_office_query_request(intent_request)
      else
        speech = 'I am going to ignore that.'
    end

    output.add_speech(speech)
    output.build_response(true)
  end

  def handle_office_workers_request(intent_request)
    Rails.logger.debug { "Intent: #{intent_request.to_json}" }
    office = intent_request['slots']['Office']['value']
    return "Hmmm, I'm not sure about your pronunciation." if office.nil?
    workers_list = Office.where("name = ?", office).includes(:workers).first.workers.collect(&:name).sort
    *all, last = workers_list
    if all.size > 1
      "Our people in #{office} are #{all.join(',')}, and last, but not least, #{last}."
    else
      "#{last} is the only person in #{office}."
    end
  end

  def handle_list_office_request(intent_request)
    office_list = Office.all.pluck(:name).sort
    *all, last = office_list
    "Our offices are in #{all.join(',')}, and last, but not least, the #{last} office."
  end

  def handle_office_query_request(intent_request)
    wanted_office = intent_request['slots']['Office']['value']
    return "Hmmm, I'm not sure about your pronunciation." if wanted_office.nil?
    office = Office.where('name = ?', wanted_office).pluck(:name)
    if office.empty?
      "No, we do not have an office in #{wanted_office}"
    elsif office.size > 1
      "Maybe, I've several matches. Please retry with clearer pronunciation."
    else
      "Yes, we do have an office in #{wanted_office}"
    end
  end

end
