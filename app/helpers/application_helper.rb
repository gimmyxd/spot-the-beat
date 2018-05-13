module ApplicationHelper
  def events_present(events)
    !spotify_events_empty(events) || filtered_events_present(events)
  end

  def spotify_events_empty(events)
    artists_with_no_events = events.values.select  { |value| value.empty? }
    artists_with_no_events.count == events.count
  end

  def filtered_events_present(events)
    events["1"].present?
  end
end
