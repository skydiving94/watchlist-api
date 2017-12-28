require "rails_helper"

RSpec.describe 'Administrator API', type: :request do
  let(:administrator) {build(:administrator)}
  let(:headers) {valid_headers.except('Authorization')}
  let(:valid_attributes) do
    attributes_for(:administrator, password_confirmation: administrator.password)
    # {
    #   name: administrator.name,
    #   email: administrator.email,
    #   password: administrator.password,
    #   password_confirmation: administrator.password
    # }
  end

  describe 'POST /signup' do
    context 'when valid request' do
      before {post '/signup', params: valid_attributes, headers: headers}

      it 'creates a new administrator' do
        expect(response).to have_http_status(201)
      end

      it 'returns a success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before {post '/signup', params: {}, headers: headers}

      it 'does not create a new administrator' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end
