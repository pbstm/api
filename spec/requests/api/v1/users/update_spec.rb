require 'rails_helper'

RSpec.describe 'PUT /api/v1/profile/update', type: :request do
  let!( :user ) { create :user }
  let( :token ) { jwt_token uid: user.id }
  let( :auth_headers ) { { 'Authorization' => token } }
  let( :avatar ) { user.avatar }

  it_behaves_like 'unauthorized', :put, '/api/v1/profile/update'

  context 'return when there are no errors ' do
    before { put_json '/api/v1/profile/update', headers: auth_headers }

    subject { response }

    it { is_expected.to have_http_status( :ok ) }

    context 'with json' do
      subject { json }

      it 'returns without params' do
        is_expected.to eq( 'success' => true	)
      end

      it 'returns with params' do
        params = {
          name: 'vasya',
          email: 'vasya@mail.com',
          current_password: '123123',
          password: '123qwe',
          password_confirmation: '123qwe'
        }
        put_json '/api/v1/profile/update', headers: auth_headers, params: params
        is_expected.to eq( 'success' => true	)
      end
    end
  end

  context 'returns errors with params' do
    subject { json }
    it 'update email without current_password' do
      params = { email: 'vasya@mail.com' }
      put_json '/api/v1/profile/update', headers: auth_headers, params: params
      is_expected.to eq(
        'success' => false,
        'errors' => [ { 'key' => 'current_password', 'messages' => [ 'Current password is required' ] } ]
      )
    end

    it 'update password without current_password' do
      params = { password: '123456' }
      put_json '/api/v1/profile/update', headers: auth_headers, params: params
      is_expected.to eq(
        'success' => false,
        'errors' => [ { 'key' => 'current_password', 'messages' => [ 'Current password is required' ] } ]
      )
    end

    it 'update password without password_confirmation' do
      params = { password: '123456',	current_password: '123123' }
      put_json '/api/v1/profile/update', headers: auth_headers, params: params
      is_expected.to eq(
        'success' => false,
        'errors' => [ { 'key' => 'password_confirmation', 'messages' => [ 'Password confirmation doesn\'t match password' ] } ]
      )
    end
  end
end
