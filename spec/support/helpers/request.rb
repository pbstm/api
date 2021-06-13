module Helpers
  module Request
    def jwt_token( payload = {} )
      JWT.encode payload, SECRET_JWT_KEY, 'HS256'
    end

    def post_json( url, params: {}, headers: {} )
      post url, params: params.to_json, headers: headers.merge( 'Content-Type' => 'application/json' )
    end

    def put_multipart( url, params: {}, headers: {} )
      put url, params: params, headers: headers.merge( 'Content-Type' => 'multipart/form-data' )
    end

    def put_json( url, params: {}, headers: {} )
      put url, params: params.to_json, headers: headers.merge( 'Content-Type' => 'application/json' )
    end

    def delete_json( url, params: {}, headers: {} )
      delete url, params: params.to_json, headers: headers.merge( 'Content-Type' => 'application/json' )
    end
  end
end
