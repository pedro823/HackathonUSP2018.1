class StudyRoom < ApplicationRecord
  validates :name,
            presence: true

  validates :fits_number,
            presence: true,
            numericality: { :greater_than_or_equal_to => 0 }

  belongs_to :institution, foreign_key: :institution_id
end
