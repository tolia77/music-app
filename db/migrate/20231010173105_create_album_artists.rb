class CreateAlbumArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :album_artists do |t|
      t.references :album, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
