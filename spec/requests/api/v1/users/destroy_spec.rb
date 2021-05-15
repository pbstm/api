require 'rails_helper'

RSpec.describe 'DELETE /api/v1/profile/destroy', type: :request do
	let!( :user ) { create :user }
	let( :token ) { jwt_token uid: user.id }
	let( :auth_headers ) { { 'Authorization' => token } }

	it_behaves_like 'unauthorized', :delete, '/api/v1/profile/destroy'

	context 'return when there are no errors ' do
		before { delete_json '/api/v1/profile/destroy', headers: auth_headers }

		subject { response }

		it { is_expected.to have_http_status( :ok ) }

		context 'with json' do
			subject { json }

			it 'returns success true' do
				is_expected.to eq( 'success' => true	)
			end
		end
	end

	context 'returns errors' do
		before { user.destroy }
		before { delete_json '/api/v1/profile/destroy', headers: auth_headers }

		subject { response }

		it { is_expected.to have_http_status( :unauthorized ) }

		context 'with json' do
			subject { json }

			it 'returns errors' do
				is_expected.to eq(
					'success' => false,
					'errors' => [ { 'key' => 'user', 'messages' => [ 'user not authorized' ] } ]
				)
			end
		end
	end
end
