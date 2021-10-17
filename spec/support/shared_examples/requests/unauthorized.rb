require 'rails_helper'

RSpec.shared_examples 'unauthorized' do |method, path|
  let( :params ) { {} }

  context 'when account is not authorized' do
    before { public_send method, path, params: params }

    it 'returns response with unauthorized status' do
      expect( response ).to have_http_status( :unauthorized )
    end

    it 'returns an array of errors' do
      expect( json ).to eq(
        'success' => false,
        'errors' => [ { 'key' => 'header', 'messages' => [ 'Header is required' ] } ]
      )
    end
  end
end
