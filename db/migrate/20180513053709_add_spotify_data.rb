class AddSpotifyData < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :spotify_data, :text
  end
end
