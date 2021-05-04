class User < ApplicationRecord
	has_secure_password

	validates :email, uniqueness: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :name, presence: true
	validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
