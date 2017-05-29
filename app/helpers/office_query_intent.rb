class OfficeQueryIntent < AlexaIntent
  def prepare_request(intent_request, session)
    log_session session

    handle_request intent_request['slots']['Office']['value']
  end

  def handle_request(wanted_office)
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
