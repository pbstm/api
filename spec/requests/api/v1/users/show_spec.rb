require 'rails_helper'

RSpec.describe 'GET /api/v1/profile/show', type: :request do
  include Docs::V1::Users::Api
  include Docs::V1::Users::Show

  let!( :user ) { create :user }
  let( :token ) { jwt_token uid: user.id }
  let( :auth_headers ) { { 'Authorization' => token } }

  it_behaves_like 'unauthorized', :get, '/api/v1/profile/show'

  context 'return when there are no errors ' do
    before { get '/api/v1/profile/show', headers: auth_headers }

    subject { response }

    it { is_expected.to have_http_status( :ok ) }

    context 'with json' do
      subject { json }

      it 'returns user info', :dox do
        user = User.last
        is_expected.to eq(
          'success' => true,
          'user' => {
            'id' => user.id,
            'name' => user.name,
            'email' => user.email,
            'updated_at' => rfc3339( user.updated_at ),
            'created_at' => rfc3339( user.created_at )
          }
        )
      end
    end
  end
end
