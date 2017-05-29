class ListOfficeIntent
  def prepare_request
    handle_request Office.all.pluck(:name).sort
  end

  def handle_request(office_list)
    return "We don't have any offices" if office_list.nil? || office_list.empty?

    *all, last = office_list
    if office_list.size > 1
      "Our offices are in #{all.join(',')}, and last but not least is the office in #{last}."
    elsif office_list.size == 1
      "#{last} is the only office."
    end
  end
end
