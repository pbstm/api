class Location < ApplicationRecord
  validates :city, presence: true
end
