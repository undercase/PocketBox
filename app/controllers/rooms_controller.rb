class RoomsController < ApplicationController
  def create
    @room = Room.find_by(code: params[:room][:name])
    unless @room
      if params[:room][:name] == "foobar"
        redirect_to root_path
      else
        @room = Room.create(room_params)
        if not @room.valid?
          redirect_to root_path, flash: {error: 'Rooms must have names.'}
        else
          hashids = Hashids.new('footlongchickenteriyaki', 6)
          @room.update(code: hashids.encode(@room.id))
          redirect_to room_path(code: @room.code)
        end
      end
    else
      redirect_to room_path(code: @room.code)
    end
  end

  def show
    @room = Room.find_by(code: params[:code])
    @speech = @room.speeches.new
  end

  def search
    @room = Room.find_by(code: params[:room][:code])
    if @room
      redirect_to room_path(code: @room.code)
    else
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
