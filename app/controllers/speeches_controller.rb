class SpeechesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @speech = @room.speeches.create(speech_params)
    message = {
      room_id: @room.id.to_s,
      url: @speech.speech_doc.url(:original, false),
      name: @speech.speech_doc.original_filename.gsub('.docx', '').gsub('_', ' ')
    }
    WebsocketRails[:speeches].trigger(:new_speech, message) if @speech
    redirect_to @room
  end

  private

  def speech_params
    params.require(:speech).permit(:speech_doc)
  end
end
