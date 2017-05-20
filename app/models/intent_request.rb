class IntentRequest
  def init params
    output = AlexaRubykit::Response.new

    request = params['request']
    intent_request = request['intent']
    intent_name = intent_request['name']

    Rails.logger.debug { "IntentRequest: #{intent_request.to_json}" }

    case intent_name
      when 'ListOffice'
        speech = prepare_list_office_request
      when 'OfficeWorkers'
        speech = prepare_office_workers_request(intent_request)
      when 'OfficeQuery'
        speech = prepare_office_query_request(intent_request)
      when 'Bookit'
        speech = prepare_bookit_request(intent_request)
      when 'AMAZON.StopIntent'
        speech = 'Peace, out.'
      else
        speech = 'I am going to ignore that.'
    end

    output.add_speech(speech)
    output.build_response(true)
  end

  def prepare_office_workers_request(intent_request)
    office_name = intent_request['slots']['Office']['value']
    office = Office.where("name = ?", office_name).includes(:workers).first
    workers = office.workers.collect(&:name).sort
    handle_office_workers_request(office_name, office, workers)
  end

  def handle_office_workers_request(office_name, office, workers)

    return "Hmmm, I'm not sure about your pronunciation." if office_name.nil? || office_name.empty?
    return "There's no one in #{office_name}. Why don't you apply to go there." if office.nil?

    *all, last = workers
    if workers.size > 1
      "Our people in #{office_name} are, #{all.join(',')}, and last but not least, is #{last}."
    elsif workers.size == 1
      "#{last} is the only person in #{office_name}. Poor #{last}"
    else
      "There's no one in #{office_name}. Why don't you apply to go there."
    end
  end

  def prepare_list_office_request
    handle_list_office_request Office.all.pluck(:name).sort
  end

  def handle_list_office_request(office_list)
    return "We don't have any offices" if office_list.nil? || office_list.empty?

    *all, last = office_list
    if office_list.size > 1
      "Our offices are in #{all.join(',')}, and last but not least, is the office in #{last}."
    elsif office_list.size == 1
      "#{last} is the only office."
    end
  end

  def prepare_bookit_request(intent_request)
    begin
      start_date = intent_request['slots']['StartDate']['value']
      end_date = intent_request['slots']['EndDate']['value'] rescue nil
      end_date = Date.parse(start_date) + 1 if end_date.nil?
    rescue StandardError => ex
      return 'I had trouble with the dates, please retry your query. The error was ' + ex.message
    end
    all_rooms = Bookit.new.get_rooms 'http://bookit.riglet.io:8888/rooms/nyc'
    booked_rooms = Bookit.new.get_booked_rooms "http://bookit.riglet.io:8888/rooms/nyc/meetings?start=#{start_date}&end=#{end_date}"
    handle_bookit_request all_rooms, booked_rooms
  end

  def handle_bookit_request(all_rooms, booked_rooms)
    return 'There are no rooms registered' if all_rooms.empty?
    return 'All rooms seem to be vacant then' if booked_rooms.empty?
    rooms = all_rooms - booked_rooms

    return 'There are no vacant rooms for those dates.' if rooms.empty?

    *all, last = rooms.sort
    p = rooms.size == 1 ? 'is' : 'are'
    speech = "Of #{all_rooms.size}, #{rooms.size} #{p} available. "

    last_speech = p
    vacant_speech = "#{last} #{last_speech} vacant for those dates."

    speech + (all.empty? ? "#{vacant_speech}" : "#{all.join(',')} and #{vacant_speech}")
  end

  def prepare_office_query_request(intent_request)
    handle_office_query_request = intent_request['slots']['Office']['value']
  end

  def handle_office_query_request(wanted_office)
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
