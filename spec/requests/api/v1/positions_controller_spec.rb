describe Api::V1::PositionsController do
  let(:user) { create(:user) }
  let!(:positions){ create_list(:position, 2) }
  let(:id){ positions.first.id }

  describe 'GET /api/v1/positions' do
    context 'when user not logged in' do
      before { get '/api/v1/positions' }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get '/api/v1/positions', headers: @auth_headers
      end

      it_behaves_like 'successful request'

      it 'returns positions' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
      end
    end
  end

  describe 'GET /api/v1/positions/:id' do
    context 'when user not logged in' do
      before { get "/api/v1/positions/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get "/api/v1/positions/#{id}", headers: @auth_headers
      end

      context 'when record is found' do
        it_behaves_like 'successful request'

        it 'returns the position' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(id)
        end
      end

      context 'when record is not found' do
        let(:id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Position/)
        end
      end
    end
  end

  describe 'POST /api/v1/positions' do
    valid_attributes = { title: 'Software Engineer' }
    context 'when user not logged in' do
      before { post '/api/v1/positions', params: valid_attributes }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { post '/api/v1/positions', params: valid_attributes, headers: @auth_headers }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'returns the position' do
          expect(json).not_to be_empty
          expect(json['title']).to eq('Software Engineer')
        end
      end

      context 'when params is not valid' do
        before { post '/api/v1/positions', params: { title: '' }, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns a validation error message' do
          expect(response.body).to match(/Validation failed: Title can't be blank/)
        end
      end
    end
  end

  describe 'PUT /api/v1/positions/:id' do
    valid_attributes = { title: 'QA' }
    context 'when user not logged in' do
      before { put "/api/v1/positions/#{id}", params: valid_attributes }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { put "/api/v1/positions/#{id}", params: valid_attributes, headers: @auth_headers }

        it_behaves_like 'successful request'

        it 'update the position' do
          expect(json).not_to be_empty
          expect(json['title']).to eq('QA')
        end
      end

      context 'when params is not valid' do
        before { put "/api/v1/positions/#{id}", params: { title: '' }, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns validation error message' do
          expect(response.body).to match(/Validation failed: Title can't be blank/)
        end
      end
    end
  end

  describe 'DELETE /api/v1/positions/:id' do
    context 'when user not logged in' do
      before { delete "/api/v1/positions/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        delete "/api/v1/positions/#{id}", headers: @auth_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'delete the position' do
        expect(Position.find_by(id: id)).to eq(nil)
      end
    end
  end
end
