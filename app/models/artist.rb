class Artist
  attr_accessor :name, :mbid, :events

  def initialize(artist_name)
    @name = artist_name
    @events = []
    add_events
  end

  def add_events
    return if event_data.blank?
    event_data.each do |event_data|
      @events.push(Concert.new(event_data))
    end
  end

  def get_upcoming_events
    @events
  end

  def event_data
    event_helper.search_setlists(@name).body['setlist']
  end

  def mbid_helper
    @mbid_helper ||= MusicbrainzHelper.new
  end

  def event_helper
    @event_helper ||= SetlistfmHelper.new
  end
end