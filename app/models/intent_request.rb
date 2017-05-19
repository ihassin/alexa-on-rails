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
      when 'AMAZON.StopIntent'
        speech = 'Peace, out.'
      when 'Bookit'
        speech = handle_bookit_request(intent_request)
      else
        speech = 'I am going to ignore that.'
    end

    output.add_speech(speech)
    output.build_response(true)
  end

  def handle_office_workers_request(intent_request)
    Rails.logger.debug { "Intent: #{intent_request.to_json}" }

    office_name = intent_request['slots']['Office']['value']
    return "Hmmm, I'm not sure about your pronunciation." if office_name.nil?
    office = Office.where("name = ?", office_name).includes(:workers).first
    return "There's no one in #{office_name}. Why don't you apply to go there." if office.nil?

    workers_list = office.workers.collect(&:name).sort
    *all, last = workers_list
    if all.size > 1
      "Our people in #{office_name} are, #{all.join(',')}, and last but not least, is #{last}."
    elsif all.size == 1
      "#{last} is the only person in #{office_name}. Poor #{last}"
    else
      "There's no one in #{office_name}. Why don't you apply to go there."
    end
  end

  def handle_list_office_request(intent_request)
    office_list = Office.all.pluck(:name).sort
    *all, last = office_list
    "Our offices are in #{all.join(',')}, and last but not least, is the office in #{last}."
  end

  def handle_bookit_request(intent_request)
    start_date = intent_request['slots']['StartDate']['value']
    end_date = intent_request['slots']['EndDate']['value']

    all_rooms = Bookit.new.get_rooms 'http://bookit.riglet.io:8888/rooms/nyc'
    booked_rooms = Bookit.new.get_rooms "http://bookit.riglet.io:8888/rooms/nyc/meetings?start=#{start_date}&end=#{end_date}"
    rooms = all_rooms - booked_rooms

    *all, last = rooms.sort
    "Rooms #{all.join(',')}, and #{last}, are vacant for those dates."
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
