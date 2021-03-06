class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_secure_password

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  scope :customer, -> { where( type: 'Customer' ) }
  scope :photographer, -> { where( type: 'Photographer' ) }
end
