class CreateJwtToken < ActiveInteraction::Base
	SECRET_KEY = Rails.configuration.jwt_secret_key

	string :email

	string :password

	validate :check_user

	def execute
		return unless @user

		encode
	end

	private

	def check_user
		@user = User.find_by( email: email )&.authenticate( password )
		errors.add :login, 'wrong email or password' unless @user
	end

	def encode
		payload = { uid: @user.id, exp: Rails.configuration.jwt_token_expire_time.from_now.to_i }
		JWT.encode payload, SECRET_KEY, 'HS256'
	end
end
