class CreateSongArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :song_artists do |t|
      t.references :song, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.boolean :primary

      t.timestamps
    end
  end
end
