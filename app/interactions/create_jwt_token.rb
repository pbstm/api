class CreateJwtToken < ActiveInteraction::Base
	SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

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
		payload = { uid: @user.id, exp: 5.days.from_now.to_i }
		JWT.encode payload, SECRET_KEY, 'HS256'
	end
end
