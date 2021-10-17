module Api
  class BaseController < ActionController::API
    private

    def render_errors( errors: [], status: :unprocessable_entity )
      render json: { success: false, errors: errors }, status: status
    end

    ##
    # This method is used to render errors on objects containing the method :errors
    # This is our standard error output format.

    # Explanation of the comment:
    # It seems to me that code that contains several lines of code and contains a simple implementation by generating
    # an array from a pair of variables does not really need comments.
    # However, I admit that someone can praise such things as religious views.
    # So far, I have not come across a single proven theory that this approach in any way affects
    # the readability and understanding of the code.
    # Moreover, I am more inclined to assume that the code base tends to change over time,
    # and only comments remain the same as if they were set in stone.
    # For my friend Alexei, perhaps it all looks different, and therefore you are reading this explanation.
    def render_resource_errors( resource, status: :unprocessable_entity )
      result = resource.errors.attribute_names.map { |attr| { key: attr, messages: resource.errors.full_messages_for( attr ) } }
      render_errors errors: result, status: status
    end

    def render_success( resource = nil, status: :ok )
      result = { success: true }
      result.merge!( resource ) if resource
      render json: result, status: status
    end
  end
end
