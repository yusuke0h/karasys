class AddOriginPathToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :origin_path, :string
  end
end
