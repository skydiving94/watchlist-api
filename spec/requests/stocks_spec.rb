require 'rails_helper'

RSpec.describe 'Watchlist API', type: :request do
  let(:administrator) {create(:administrator)}
  let!(:stocks) {create_list(:stock, 10, added_by: administrator.id)}
  let(:stock_id) {stocks.first.id}
  let(:headers) {valid_headers}

  let(:valid_post_attributes) {
    {
      code: 'MSFT',
      name: 'Microsoft Corp',
      highest: 48.42,
      lowest: 48.42,
      current: 48.42,
      difference: 0,
      # added_by: administrator
    }
  }

  let(:valid_put_attributes) {
    {
      current: 48.42
    }
  }

  let(:invalid_attributes) {
    {
      code: 'FOO'
    }
  }

  describe 'GET /stocks' do
    before {get '/stocks', params: {}, headers: {}}

    it 'returns stocks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /stocks' do
    context 'when the request is valid' do
      before {post '/stocks', params: valid_post_attributes, headers: headers}

      it 'creates a stock' do
        expect(json['code']).to eq('MSFT')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/stocks', params: invalid_attributes, headers: headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to include("Validation failed:")
      end
    end
  end

  describe 'GET /stocks/:id' do
    before {get "/stocks/#{stock_id}", params: {}, headers: {}}

    context 'when the record exists' do
      it 'returns the stock' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(stock_id)
      end

      it 'returns status code 200' do
        expect(response). to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:stock_id) {100}

      it 'returns the status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find")
      end
    end
  end

  describe 'PUT /stocks/:id' do
    context 'when the record exists and the request is valid' do
      before {put "/stocks/#{stock_id}", params: valid_put_attributes, headers: headers}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      let(:stock_id) {100}
      before {put "/stocks/#{stock_id}", params: valid_put_attributes, headers: headers}

      it 'returns the status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find")
      end
    end
  end

  describe 'DELETE /stocks/:id' do
    before {delete "/stocks/#{stock_id}", params: {}, headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
