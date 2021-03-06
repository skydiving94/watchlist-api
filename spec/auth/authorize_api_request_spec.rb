require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:administrator) {create(:administrator)}
  let(:header) {{'Authorization' => token_generator(administrator.id)}}

  subject(:invalid_request_obj) {described_class.new({})}
  subject(:request_obj) {described_class.new(header)}

  describe '#call' do
    context 'when valid request' do
      it 'returns administrator object' do
        result = request_obj.call
        expect(result[:administrator]).to eq(administrator)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect {invalid_request_obj.call}.to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises an InvalidToken error' do
          expect {invalid_request_obj.call}.to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'when token is expired' do
        let(:header) {{'Authorization' => expired_token_generator(administrator.id)}}
        subject(:request_obj) {described_class.new(header)}

        it 'raises ExceptionHandler::ExpiredSignature error' do
          expect {request_obj.call}.to raise_error(ExceptionHandler::ExpiredSignature, /Signature has expired/)
        end
      end
    end
  end
end
