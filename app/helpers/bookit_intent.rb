class BookitIntent
  def prepare_request(intent_request)
    begin
      start_date = intent_request['slots']['StartDate']['value'] rescue nil
      end_date = intent_request['slots']['EndDate']['value'] rescue nil

      start_date = Date.today.to_s if start_date.nil?
      end_date = Date.parse(start_date) + 1 if end_date.nil?
    rescue StandardError => ex
      return 'I had trouble with the dates, please retry your query. The error was ' + ex.message
    end
    all_rooms = Bookit.new.get_rooms 'http://bookit.riglet.io:8888/rooms/nyc'
    booked_rooms = Bookit.new.get_booked_rooms "http://bookit.riglet.io:8888/rooms/nyc/meetings?start=#{start_date}&end=#{end_date}"
    handle_request all_rooms, booked_rooms, start_date, end_date
  end

  def handle_request(all_rooms, booked_rooms, start_date, end_date)
    return 'There are no rooms registered' if all_rooms.empty?
    return 'All rooms seem to be vacant then' if booked_rooms.empty?
    rooms = all_rooms - booked_rooms

    return 'There are no vacant rooms for those dates.' if rooms.empty?

    *all, last = rooms.sort
    plural_form = rooms.size == 1 ? 'is' : 'are'
    speech = "Of #{all_rooms.size}, #{rooms.size} #{plural_form} available. "

    last_speech = plural_form
    vacant_speech = "#{last} #{last_speech} vacant between #{start_date} and #{end_date}"

    speech + (all.empty? ? "#{vacant_speech}" : "#{all.join(',')} and #{vacant_speech}")
  end

end