class CreateStudyRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :study_rooms do |t|
      t.string :name
      t.integer :institution_id
      t.integer :fits_number
      t.boolean :is_free
      t.timestamps
    end
  end
end
