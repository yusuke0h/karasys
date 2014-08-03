# encoding: utf-8

class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(:id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  def create
    @reservation = Song.find(params[:format]).reservations.build

    if @reservation.save
      redirect_to reservations_path, notice: '予約が完了しました．'
    else
      redirect_to reservations_path, notice: '予約に失敗しました．'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end

  def search
    @query = params[:q]
    if @query
      @songs = Song.where( " name like ? OR title like ? OR artist like ? OR album like ? ", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%" )
    end
  end

  def preview
    @folder_path = Rails.root + "public/karadata"
    @files = []
    require 'find'
    exts = [".mp3", ".mp4", ".flv"]
    Find.find(@folder_path) {|f|
      # @files << f.gsub("#{Rails.root}/public","") if exts.include?(File.extname(f))
      @files << f if exts.include?(File.extname(f))
    }

    require 'audioinfo'
    @infolist = []
    AudioInfo.open(@files[0]) do |info|
      @infolist << info.artist   # or info["artist"]
      @infolist << info.title    # or info["title"]
      @infolist << info.length   # playing time of the file
      @infolist << info.bitrate  # average bitrate
      @infolist << info.to_h     # { "artist" => "artist", "title" => "title", etc... }
    end
  end
end
