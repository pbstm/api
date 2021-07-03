class PhotoSession < ApplicationRecord
  mount_uploader :cover, CoverUploader
  belongs_to :location
  belongs_to :photographer

  validates :title, :description, presence: true
end
