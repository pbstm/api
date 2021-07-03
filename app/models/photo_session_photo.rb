class PhotoSessionPhoto < ApplicationRecord
  mount_uploader :photo, PhotoSessionPhotoUploader

  belongs_to :photo_session

  validates :photo, presence: true
end
