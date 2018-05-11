class Concert
attr_accessor :id, :date, :venue, :city, :country, :coords

  def initialize(event_data)
    parse_event_data(event_data)
  end

  def parse_event_data(event_data)
    @id = event_data['id']
    @date = event_data['eventDate']
    @venue = event_data['venue']['name']
    @city = event_data['venue']['city']['name']
    @coords = event_data['venue']['city']['coords']
    @country = event_data['venue']['city']['country']
  end
  
end