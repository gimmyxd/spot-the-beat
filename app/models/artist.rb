class Artist
  attr_accessor :name, :events

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
    @events.select {|event| event.date > Date.yesterday}
  end

  def event_data
    event_helper.filter_setlists({artistName: @name,
                                  p: '1',
                                  year: Date.current.year.to_s}).body['setlist']
  end

  def mbid_helper
    @mbid_helper ||= MusicbrainzHelper.new
  end

  def event_helper
    @event_helper ||= SetlistfmHelper.new
  end
end