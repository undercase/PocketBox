class CreateSpeeches < ActiveRecord::Migration
  def change
    create_table :speeches do |t|
      t.belongs_to :room, index: true

      t.timestamps null: false
    end
  end
end
