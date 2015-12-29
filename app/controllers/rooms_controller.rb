class RoomsController < ApplicationController
  def create
    code = Array.new(6){rand(36).to_s(36)}.join until Room.where(code: code).empty? && !code.nil?
    @room = Room.create(room_params.merge({ code: code }))
    redirect_to @room
  end

  def show
    @room = Room.find(params[:id])
    @speech = @room.speeches.new
  end

  def search
    @room = Room.find_by(code: params[:room][:code])
    if @room
      redirect_to @room
    else
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
