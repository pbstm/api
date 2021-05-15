module Api
	module V1
		class UsersController < Api::AuthenticatedController
			skip_before_action :authorize, only: %i[create login]

			def show
				render_success UsersBlueprint.render_as_hash( current_user, view: :extended, root: :user )
			end

			def create
				subject = Users::CreateUser.run params
				return render_resource_errors subject unless subject.valid?

				render_success UsersBlueprint.render_as_hash( subject.result, view: :extended, root: :user ), status: :created
			rescue BCrypt::Errors::InvalidHash
				render_errors errors: [ { key: :password, messages: [ I18n.t( 'users.errors.inappropriate_password' ) ] } ]
			end

			def update
				subject = Users::UpdateUser.run params.merge( user: current_user )
				return render_resource_errors subject unless subject.valid?

				render_success
			end

			def destroy
				subject = Users::DestroyUser.run user: current_user
				return render_resource_errors subject unless subject.valid?

				render_success
			end

			def login
				subject = CreateJwtToken.run params
				return render_resource_errors subject, status: :unauthorized unless subject.valid?

				render_success( { token: subject.result } )
			end
		end
	end
end
