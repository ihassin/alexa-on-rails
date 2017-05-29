class ListWorkersIntent < AlexaIntent
  def prepare_request(intent_request, session)
    log_session session

    office_name = intent_request['slots']['Office']['value']
    return "Hmmm, I'm not sure about your pronunciation." if office_name.nil? || office_name.empty?
    office = Office.where('name = ?', office_name).includes(:workers).first
    workers = office.workers.collect(&:name).sort
    handle_request office_name, office, workers
  end

  def handle_request(office_name, office, workers)
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
end
