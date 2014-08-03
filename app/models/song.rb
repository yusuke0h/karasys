class Song < ActiveRecord::Base
  has_many :reservations
  attr_accessible :album, :artist, :name, :path, :title, :origin_path
end
