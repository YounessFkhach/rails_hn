require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create test user
  let(:user) { {'facebook_token' => 'EAAHitePoC7kBABxZB4mD9tEiUdBbxZC34r0ii5xYaIUmv9rFoniepE6WkIY5w5gDhS1BwWOaDgdX6CssMIc20sVA7PvnHbzRSO72SxziIE2BXTIZAqP51UeSOoolhisDCJjvI7MBtCZCz8EV9CACo9WR8iEOuAZCf0SaqpcPUehUNpRcUuqjC'} }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(user['facebook_token']) }
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new('foobar') }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid token/
          )
      end
    end
  end
end