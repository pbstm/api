module Users
  class CreateUser < ActiveInteraction::Base
    USERTYPES = %w[Customer Photographer].freeze
    string :name, :email, :password, :password_confirmation, :type

    validate :check_type

    def execute
      user = User.new inputs

      errors.merge! user.errors unless user.save
      user
    end

    private

    def check_type
      errors.add :type, :wrong unless type.in? USERTYPES
    end
  end
end
