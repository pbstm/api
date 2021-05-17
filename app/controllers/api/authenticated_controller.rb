module Api
  class AuthenticatedController < Api::BaseController
    class UserNotAuthorized < StandardError
      def message
        I18n.t( 'users.errors.user_not_authorized' )
      end
    end

    rescue_from Api::AuthenticatedController::UserNotAuthorized, with: :user_not_authorized

    before_action :authorize

    private

    def user_not_authorized( exception )
      render_errors errors: [ { key: :user, messages: [ exception.message ] } ], status: 401
    end

    def current_user
      user = User.find_by( id: @current_user_id )
      raise Api::AuthenticatedController::UserNotAuthorized unless user

      user
    end

    def authorize
      subject = CheckAuthorize.run header: request.headers[ 'Authorization' ]
      return render_resource_errors subject, status: :unauthorized unless subject.valid?

      @current_user_id = subject.result[ :uid ]
    end
  end
end
