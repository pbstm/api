class ErrorMessages
  class << self
    def inapropriate_password
      I18n.t( 'users.errors.inappropriate_password' )
    end
  end
end
