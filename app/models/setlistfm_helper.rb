require 'faraday'
require 'faraday_middleware'

class SetlistfmHelper
  include Faraday

  VERSION = "0.0.1"
  API_VERSION = "1.0"
  URL = "https://api.setlist.fm"

  attr_accessor :api_version, :url

  def initialize(url = URL)
    @api_version = API_VERSION
    @url = url
    @http = Faraday.new(@url) do |f|
      f.headers[:user_agent] = "Setlistfm/#{SetlistfmHelper::VERSION}"
      f.headers['Accept'] = 'application/json'
      f.headers['x-api-key'] = '1e56c04c-95a2-4641-8219-1cf8cfdf6041'
      f.request  :url_encoded
      f.response :json
      f.use      :gzip
      f.adapter  :net_http
    end
  end

  def artist mbid
    @http.get "/rest/#{@api_version}/artist/#{mbid}"
  end

  def city geo_id
    @http.get "/rest/#{@api_version}/city/#{geo_id}"
  end

  def setlist setlist_id
    @http.get "/rest/#{@api_version}/setlist/#{setlist_id}"
  end

  def user user_id
    @http.get "/rest/#{@api_version}/user/#{user_id}"
  end

  def venue venue_id
    @http.get "/rest/#{@api_version}/venue/#{venue_id}"
  end

  def artist_setlists mbid
    @http.get "/rest/#{@api_version}/artist/#{mbid}/setlists"
  end

  def setlist_lastfm lastfm_event_id
    @http.get "/rest/#{@api_version}/setlist/lastFm/#{lastfm_event_id}"
  end

  def setlist_version version_id
    @http.get "/rest/#{@api_version}/setlist/version/#{version_id}"
  end

  def user_attended user_id
    @http.get "/rest/#{@api_version}/user/#{user_id}/attended"
  end

  def user_edited user_id
    @http.get "/rest/#{@api_version}/user/#{user_id}/edited"
  end

  def search_cities
    @http.get "/rest/#{@api_version}/1.0/search/cities"
  end

  freeze
end
