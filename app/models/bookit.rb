class Bookit
  def get_rooms(query_url)
    rooms = []
    doc = JSON.parse(open(query_url).read)
    doc['rooms'].each do |room|
      rooms << room['name']
    end
    rooms
  end

  def get_booked_rooms(query_url)
    rooms = []
    doc = JSON.parse(open(query_url).read)
    doc.each do |room|
      rooms << room['room']['name'] unless room['meetings'].size < 9
    end
    rooms
  end
end
