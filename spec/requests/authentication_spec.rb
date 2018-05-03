# spec/requests/authentication_spec.rb
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication test suite
  describe 'POST /auth/login' do
    # create test user
    let!(:user) { { 'facebook_token' => 'EAAHitePoC7kBABxZB4mD9tEiUdBbxZC34r0ii5xYaIUmv9rFoniepE6WkIY5w5gDhS1BwWOaDgdX6CssMIc20sVA7PvnHbzRSO72SxziIE2BXTIZAqP51UeSOoolhisDCJjvI7MBtCZCz8EV9CACo9WR8iEOuAZCf0SaqpcPUehUNpRcUuqjC'} }
    # set headers for authorization
    let(:headers) { { "Content-Type" => "application/json" } }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        'facebook_token'=> 'EAAHitePoC7kBABxZB4mD9tEiUdBbxZC34r0ii5xYaIUmv9rFoniepE6WkIY5w5gDhS1BwWOaDgdX6CssMIc20sVA7PvnHbzRSO72SxziIE2BXTIZAqP51UeSOoolhisDCJjvI7MBtCZCz8EV9CACo9WR8iEOuAZCf0SaqpcPUehUNpRcUuqjC'
      }.to_json
    end
    let(:invalid_credentials) do
      {
        'facebook_token'=> 'ASDFASDFLJ'
      }.to_json
    end

    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid token/)
      end
    end
  end
end