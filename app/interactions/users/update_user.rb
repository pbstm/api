module Users
  class UpdateUser < ActiveInteraction::Base
    object :user
    string :name, default: nil
    string :email, default: nil
    file :avatar, default: nil
    string :password, default: nil
    string :password_confirmation, default: nil
    string :current_password, default: nil

    validate :check_current_password

    def execute
      return if errors.messages.present?

      errors.merge! user.errors unless user.update inputs.without( :user, :current_password ).compact
    end

    def check_current_password
      return unless email || password
      return errors.add :current_password, I18n.t( 'users.errors.required' ) unless current_password
      return errors.add :current_password, I18n.t( 'users.errors.wrong' ) unless user.authenticate( current_password )

      errors.add :password_confirmation, I18n.t( 'users.errors.password_mismatch' ) if password != password_confirmation
    end
  end
end
