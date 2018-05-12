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
      f.headers['x-api-key'] = Rails.application.credentials.setlistfm[:api_key]
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

  def search_setlists name
    @http.get "/rest/#{@api_version}/search/setlists/" do |r|
      r[:artistName]=name
      r[:p]= '1'
      r[:year] = Date.current.year.to_s
    end
  end

  def filter_setlists params
    @http.get "/rest/#{@api_version}/search/setlists/" do |r|
      r.params = params
    end
  end

  freeze
end
