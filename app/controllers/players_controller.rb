class PlayersController < ApplicationController

  def interval
    @next_reservations = Reservation.where(reproduced: false).order(:id)[0..4]

  end

  def play
    @now_reservation = Reservation.where(reproduced: false).order(:id).first
    if @now_reservation.nil?
      sleep 3
      redirect_to players_interval_path
      return
    end
    render :action => "play", :layout => false
  end

  def done
    @now_reservation = Reservation.where(reproduced: false).order(:id).first
    @now_reservation.reproduced = true
    @now_reservation.save
    redirect_to players_interval_path
  end

end
