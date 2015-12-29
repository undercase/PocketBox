class AddFileColumnsToSpeeches < ActiveRecord::Migration
  def up
    add_attachment :speeches, :speech_doc
  end

  def down
    remove_attachment :speeches, :speech_doc
  end
end
