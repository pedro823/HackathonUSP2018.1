class Institution < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true

  belongs_to :location, foreign_key: :location_id
end
