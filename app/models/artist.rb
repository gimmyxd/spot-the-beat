class Artist
  attr_accessor :name, :mbid, :events

  def initialize(artist_name)
    @name = artist_name
    @mbid = mbid_helper.artist_id(artist_name)
    @events = []
  end

  def add_events
    event_data.each do |event_data|
      @events.push(Concert.new(event_data))
    end
  end

  def event_data
    event_helper.artist_setlists(@mbid).body['setlist']
  end

  def mbid_helper
    @mbid_helper ||= MusicbrainzHelper.new
  end

  def event_helper
    @event_helper ||= SetlistfmHelper.new
  end
end