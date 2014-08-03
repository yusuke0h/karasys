class Reservation < ActiveRecord::Base
  belongs_to :song
  attr_accessible :reproduced, :song_id
end
