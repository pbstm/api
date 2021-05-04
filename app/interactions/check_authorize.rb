class CheckAuthorize < ActiveInteraction::Base
	SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

	string :header

	validates :header, presence: true

	validate :decode

	def execute
		@decode_token
	end

	def decode
		token = header.split.last
		decoded = JWT.decode( token, SECRET_KEY, true, { algorithm: 'HS256' } )[ 0 ]
		@decode_token = HashWithIndifferentAccess.new decoded
	rescue JWT::DecodeError => error
		errors.add :authorize, error
	end
end
