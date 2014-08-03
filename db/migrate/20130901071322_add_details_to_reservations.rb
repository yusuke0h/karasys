class AddDetailsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :reproduced, :boolean, :null => false, :default => false
    add_column :reservations, :song_id, :integer
  end
end
