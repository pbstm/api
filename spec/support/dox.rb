RSpec.configure do |config|
  config.after :each, :dox do |example|
    example.metadata[ :request ] = request
    example.metadata[ :response ] = response

    if request && request.headers[ 'CONTENT_TYPE' ]&.start_with?( 'multipart/form-data; boundary=' )
      patched_request = request.dup

      def patched_request.body
        OpenStruct.new read: request_parameters.to_json
      end

      example.metadata[ :request ] = patched_request
    end
  end
end

Dox.configure do |config|
  config.headers_whitelist = %w[Content-Type Authorization]
end
