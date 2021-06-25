class CreateJwtToken < ActiveInteraction::Base
  SECRET_KEY = Rails.configuration.jwt_secret_key
  USER_TYPES = %w[Customer Photographer].freeze

  string :email
  string :password
  string :type, default: USER_TYPES.first

  validate :check_user
  validate :check_type

  def execute
    return unless @user

    @user.update type: type
    encode
  end

  private

  attr_reader :invalid

  def check_user
    @user = User.find_by( email: email )&.authenticate( password )
    errors.add :invalid, :login unless @user
  end

  def check_type
    errors.add :type, :invalid unless type.in? USER_TYPES
  end

  def encode
    payload = { uid: @user.id, exp: Rails.configuration.jwt_token_expire_time.from_now.to_i }
    JWT.encode payload, SECRET_KEY, 'HS256'
  end
end
