class PhotoSession < ApplicationRecord
  validates :title
  validates :description
  validates :photographer_id, presence: true
end
