class RemoveReleasedAtFromSongs < ActiveRecord::Migration[7.0]
  def change
    remove_column :songs, :released_at, :datetime
  end
end
