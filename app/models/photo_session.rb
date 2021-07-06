class PhotoSession < ApplicationRecord
  mount_uploader :cover, CoverUploader
  belongs_to :location
  belongs_to :photographer
  has_many :photo_session_photos, dependent: :destroy

  accepts_nested_attributes_for :photo_session_photos, allow_destroy: true, reject_if: -> a { a[ :photo ].blank? }

  validates :title, :description, presence: true
end
