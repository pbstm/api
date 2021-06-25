module Users
  class CreateUser < ActiveInteraction::Base
    string :name, :email, :password, :password_confirmation

    def execute
      user = User.new inputs

      errors.merge! user.errors unless user.save
      user
    end
  end
end
