class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def entry
    Song.all.each do |song|
      song.destroy
    end
    Reservation.all.each do |reservation|
      reservation.destroy
    end

    row_folders = ["public/karadata_row/"]
    # txt_path = "#{Rails.root}/config/entry_folder.txt"
    # IO.readlines(txt_path).each do |line|
    #   row_folders << line.strip if line.size > 2
    # end
    use_folder = Rails.root + "public/karadata_use"
    FileUtils.rm_r( Dir.glob( use_folder ), {:force=>true} )
    FileUtils.mkdir_p("#{use_folder}") unless FileTest.exist?("#{use_folder}")

    files = []
    require 'find'
    exts = {".mp3" => true,
           ".mp4" => true}
    index = 1
    row_folders.each do |row_folder|
      Find.find(row_folder) {|src|
        file_ext = File.extname(src)
        if exts[file_ext]
          file_name = File.basename(src)
          mv_file_name = "#{use_folder}/#{index.to_s + file_ext}"
          FileUtils.move(src, mv_file_name)
          files << {:origin_path => src, :path => mv_file_name }
          index += 1
        end
      }
    end

    # render :text => files

    require 'audioinfo'
    files.each do |paths|
      AudioInfo.open(paths[:path]) do |info|
        paths[:metadata] = info.to_h
      end
    end
    files.each do |paths|
      neme = File.basename(paths[:origin_path])
      origin_path = paths[:origin_path].gsub("#{Rails.root}/public" ,"")
      path = paths[:path].gsub("#{Rails.root}/public" ,"")
      title = paths[:metadata]["title"]
      artist = paths[:metadata]["artist"]
      album = paths[:metadata]["album"]
      h = {:name => neme, :path => path, :title => title, :artist => artist, :album => album, :origin_path => origin_path}
      @song = Song.create h
    end
    redirect_to songs_index_path
  end
end
