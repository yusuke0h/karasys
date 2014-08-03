class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, :null => false
      t.string :path, :null => false
      t.string :title
      t.string :artist
      t.string :album

      t.timestamps
    end
  end
end
