require 'rails_helper'

RSpec.describe 'POST /api/v1/sign_up', type: :request do
  include Docs::V1::Users::Api
  include Docs::V1::Users::Sign_up

  let!( :params ) do
    {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: '123123',
      password_confirmation: '123123'
    }
  end
  context 'return when there are no errors ' do
    before { post_json '/api/v1/sign_up', params: params }

    subject { response }

    it { is_expected.to have_http_status( :created ) }

    context 'with json' do
      subject { json }

      it 'returns success', :dox do
        user = User.last
        is_expected.to eq(
          'success' => true,
          'user' => {
            'id' => user.id,
            'name' => user.name,
            'email' => user.email,
            'updated_at' => rfc3339( user.updated_at ),
            'created_at' => rfc3339( user.created_at ),
            'avatar_url' => user.avatar.url
          }
        )
      end
    end
  end

  context 'returns errors', :dox do
    before { post_json '/api/v1/sign_up' }

    subject { response }

    it { is_expected.to have_http_status( :unprocessable_entity ) }

    context 'with json' do
      subject { json }

      it 'without name' do
        params[ :name ] = ''
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
            'key' => 'name',
            'messages' => [ 'Name can\'t be blank' ]
            }
          ]
        )
      end

      it 'without password' do
        params[ :password ] = ''
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password',
              'messages' => [ "Password can't be blank", 'Password is too short (minimum is 6 characters)' ]
            }
          ]
        )
      end

      it 'when the password is less than 6 characters' do
        params[ :password ] = '12345'
        params[ :password_confirmation ] = '12345'
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password',
              'messages' => [ 'Password is too short (minimum is 6 characters)' ]
            }
          ]
        )
      end

      it 'without password_confirmation' do
        params[ :password_confirmation ] = ''
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password_confirmation',
              'messages' => [ 'Password confirmation doesn\'t match Password' ]
            }
          ]
        )
      end

      it 'when the password is more than 72 characters' do
        params[ :password ] = '1' * 73
        params[ :password_confirmation ] = '1' * 73
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password',
              'messages' => [ 'Password is too long (maximum is 72 characters)' ]
            }
          ]
        )
      end

      it 'when the password is more than 511 characters' do
        params[ :password ] = '1' * 512
        params[ :password_confirmation ] = '1' * 512
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password',
              'messages' => [ 'inappropriate password' ]
            }
          ]
        )
      end

      it 'when the email is incorrect' do
        params[ :email ] = 'asdasd'
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'email',
              'messages' => [ 'Email is invalid' ]
            }
          ]
        )
      end

      it 'when email is already in use ' do
        user = create :user
        params[ :email ] = user.email
        post_json '/api/v1/sign_up', params: params
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'email',
              'messages' => [ 'Email has already been taken' ]
            }
          ]
        )
      end
    end
  end
end
