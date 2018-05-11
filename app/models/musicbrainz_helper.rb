require 'musicbrainz'

class MusicbrainzHelper

  def initialize
    MusicBrainz.configure do |c|
      # Application identity (required)
      c.app_name = 'Spot the Beat'
      c.app_version = '0.1'
      c.contact = 'support@mymusicapp.com'
    end
  end

  def artist_id artist_name
    MusicBrainz::Artist.find_by_name(artist_name).id
  end
end