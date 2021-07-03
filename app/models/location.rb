class Location < ApplicationRecord
  has_one :photo_session
  validates :city, presence: true
end
