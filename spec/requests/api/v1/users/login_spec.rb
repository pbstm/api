require 'rails_helper'

RSpec.describe 'POST /api/v1/sign_in', type: :request do
  include Docs::V1::Users::Api
  include Docs::V1::Users::Sign_in

  let!( :user ) { create :user }
  let!( :params ) { { email: user.email, password: '123123' } }

  context 'return when there are no errors ' do
    before { post_json '/api/v1/sign_in', params: params }

    subject { response }

    it { is_expected.to have_http_status( :ok ) }

    context 'with json' do
      subject { json }

      it 'returns success', :dox do
        is_expected.to include( 'success' => true )
      end
    end

    context 'with keys' do
      let( :fields ) { %w[success token] }
      subject { json.keys }
      it { is_expected.to contain_exactly( *fields ) }
    end
  end

  context 'returns errors', :dox do
    before { post_json '/api/v1/sign_in' }

    subject { response }

    it { is_expected.to have_http_status( :unauthorized ) }

    context 'with json' do
      subject { json }

      it 'without email' do
        post_json '/api/v1/sign_in', params: { password: '123123' }
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
            'key' => 'email',
            'messages' => [ 'Email is required' ]
            }
          ]
        )
      end

      it 'without password' do
        post_json '/api/v1/sign_in', params: { email: user.email }
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
            'key' => 'password',
            'messages' => [ 'Password is required' ]
            }
          ]
        )
      end

      it 'when password or email incorrect' do
        post_json '/api/v1/sign_in', params: { email: user.email, password: 'xxx' }
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
            'key' => 'login',
            'messages' => [ 'Login wrong email or password' ]
            }
          ]
        )
      end
    end
  end
end
