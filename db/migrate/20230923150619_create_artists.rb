class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :description
      t.references :user, null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
