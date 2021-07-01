class PhotoSession < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :photographer_id, presence: true
end
