class SpeechesController < ApplicationController
  def create
    @room = Room.find_by(code: params[:code])
    if @room
      @speech = @room.speeches.create(speech_params)
      message = {
        room_id: @room.id.to_s,
        url: @speech.speech_doc.url(:original, false),
        name: @speech.speech_doc.original_filename.gsub('.docx', '').gsub('_', ' ')
      }
      WebsocketRails[:speeches].trigger(:new_speech, message) if @speech
      redirect_to room_path(code: @room.code)
    else
      redirect_to root_path
    end
  end

  def destroy
    @room = Room.find_by(code: params[:code])
    if @room
      @speech = Speech.find(params[:speech_id])
      if @speech
        @speech.destroy
      end
      redirect_to room_path(code: @room.code)
    else
      redirect_to root_path
    end
  end

  def delete
    @room
  end

  private

  def speech_params
    params.require(:speech).permit(:speech_doc)
  end
end
