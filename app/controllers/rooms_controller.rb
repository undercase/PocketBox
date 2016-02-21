class RoomsController < ApplicationController
  def create
    @room = Room.create(room_params)
    hashids = Hashids.new('footlongchickenteriyaki', 6)
    @room.update(code: hashids.encode(@room.id))
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
