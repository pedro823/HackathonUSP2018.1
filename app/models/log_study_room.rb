class LogStudyRoom < ApplicationRecord
  validates :time_of_day,
            numericality: {
              greater_than_or_equal_to: 0,
              smaller_than_or_equal_to: 86400
            }
  belongs_to :study_room, foreign_key: :study_room_id
end
