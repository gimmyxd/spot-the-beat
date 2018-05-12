class FilteredEvents
  attr_accessor :name, :mbid, :events

  def initialize(params)
    @events = []
    add_events(params)
  end

  def add_events(params)
    return if event_data(params).blank?
    event_data(params).each do |event_data|
      @events.push(Concert.new(event_data))
    end
  end

  def get_filtered_events
    @events.select {|event| event.date > Date.yesterday}
  end

  def event_data(params)
    event_helper.filter_setlists(params).body['setlist']
  end

  def event_helper
    @event_helper ||= SetlistfmHelper.new
  end
end
