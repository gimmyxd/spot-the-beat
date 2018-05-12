class DashboardController < ApplicationController
  def index
    @top_artists = current_spotify_user.top_artists(limit: 10, offset: 0, time_range: 'short_term')
    @events = @top_artists.map do |a|
      artist_events = Rails.cache.fetch(a.id)

      if artist_events.blank?
        artist_events = Artist.new(a.name).get_upcoming_events
        Rails.cache.write(a.id, artist_events, expires_in: 3.hours)
      end

      [a.id, artist_events]
    end.to_h
    respond_to do |format|
      format.html
      format.json {render json: @events, status: :ok}
    end
  end
end
