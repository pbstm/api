class PhotoSession < ApplicationRecord
  mount_uploader :cover, CoverUploader
  belongs_to :location
  belongs_to :photographer
  has_many :photo_session_photos, dependent: :destroy

  validates :title, :description, presence: true
end
