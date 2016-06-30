class Speech < ActiveRecord::Base
  belongs_to :room
  has_attached_file :speech_doc
  validates_attachment :speech_doc, :content_type => { :content_type => %w(application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/pdf application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet text/plain) }
end
