describe Api::V1::DepartmentsController do
  let(:user) { create(:user) }
  let!(:positions){ create_list(:position, 2) }
  let(:id){ positions.first.id }

  describe 'GET /api/v1/positions' do
    context 'when user not logged in' do
      before { get '/api/v1/positions' }

      it 'should return status 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get '/api/v1/positions', headers: @auth_headers
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return positions' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
    end
  end

  describe 'GET /api/v1/departments/:id' do
    context 'when user not logged in' do
      before { get "/api/v1/positions/#{id}" }

      it 'should return status 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get "/api/v1/positions/#{id}", headers: @auth_headers
      end

      context 'when record is found' do
        it 'should return status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'should return the position' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(id)
        end
      end

      context 'when record is not found' do
        let(:id) { 0 }

        it 'should return status 404' do
          expect(response).to have_http_status(404)
        end

        it 'should return a not found message' do
          expect(response.body).to match(/Couldn't find Position/)
        end
      end
    end
  end

  describe 'POST /api/v1/positions' do
    valid_attributes = { title: 'Software Engineer' }
    context 'when user not logged in' do
      before { post '/api/v1/positions', params: valid_attributes }

      it 'should return status 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { post '/api/v1/positions', params: valid_attributes, headers: @auth_headers }

        it 'should return status 201' do
          expect(response).to have_http_status(201)
        end

        it 'should return the position' do
          expect(json).not_to be_empty
          expect(json['title']).to eq('Software Engineer')
        end
      end

      context 'when params is not valid' do
        before { post '/api/v1/positions', params: { title: '' }, headers: @auth_headers }

        it 'should return status 422' do
          expect(response).to have_http_status(422)
        end

        it 'should return a validation error message' do
          expect(response.body).to match(/Validation failed: Title can't be blank/)
        end
      end
    end
  end

  describe 'PUT /api/v1/positions/:id' do
    valid_attributes = { title: 'QA' }
    context 'when user not logged in' do
      before { put "/api/v1/positions/#{id}", params: valid_attributes }
      it 'should return status 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { put "/api/v1/positions/#{id}", params: valid_attributes, headers: @auth_headers }
        it 'should return status 200' do
          expect(response).to have_http_status(200)
        end

        it 'should update the position' do
          expect(json).not_to be_empty
          expect(json['title']).to eq('QA')
        end
      end

      context 'when params is not valid' do
        before { put "/api/v1/positions/#{id}", params: { title: '' }, headers: @auth_headers }

        it 'should return status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns validation error message' do
          expect(response.body).to match(/Validation failed: Title can't be blank/)
        end
      end
    end
  end

  describe 'DELETE /api/v1/positions/:id' do
    context 'when user not logged in' do
      before { delete "/api/v1/positions/#{id}" }
      it 'should return status 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        delete "/api/v1/positions/#{id}", headers: @auth_headers
      end

      it 'should return status 204' do
        expect(response).to have_http_status(204)
      end

      it 'delete the position' do
        expect(Position.find_by(id: id)).to eq(nil)
      end
    end
  end
end
