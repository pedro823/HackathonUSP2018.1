class CreateLogStudyRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :log_study_rooms do |t|
      t.integer :study_room_id
      t.boolean :taken
      t.integer :time_of_day
      t.timestamps
    end
  end
end
