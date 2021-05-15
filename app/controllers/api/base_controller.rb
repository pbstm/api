module Api
	class BaseController < ActionController::API
		private

		def render_errors( errors: [], status: :unprocessable_entity )
			render json: { success: false, errors: errors }, status: status
		end

		def render_resource_errors( resource, status: :unprocessable_entity )
			result = resource.errors.attribute_names.map { | attr | { key: attr, messages: resource.errors.full_messages_for( attr ) } }
			render_errors errors: result, status: status
		end

		def render_success( resource = nil, status: :ok )
			result = { success: true }
			result.merge!( resource ) if resource
			render json: result, status: status
		end
	end
end
