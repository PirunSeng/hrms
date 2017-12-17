describe Api::V1::Profile::UsersController do
  let(:user) { create(:user) }
  let!(:users){ create_list(:user, 2) }
  let(:id){ users.first.id }

  describe 'GET /api/v1/profile/users' do
    context 'when user not logged in' do
      before { get '/api/v1/profile/users' }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get '/api/v1/profile/users', headers: @auth_headers
      end

      it_behaves_like 'successful request'

      it 'returns users' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
    end
  end

  describe 'GET /api/v1/profile/users/:id' do
    context 'when user not logged in' do
      before { get "/api/v1/profile/users/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get "/api/v1/profile/users/#{id}", headers: @auth_headers
      end

      context 'when record is found' do
        it_behaves_like 'successful request'

        it 'returns the user' do
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
          expect(response.body).to match(/Couldn't find User/)
        end
      end
    end
  end

  describe 'POST /api/v1/profile/users' do
    valid_attributes = { title: 'Software Engineer' }
    context 'when user not logged in' do
      before { post '/api/v1/profile/users', params: valid_attributes }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { post '/api/v1/profile/users', params: valid_attributes, headers: @auth_headers }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'returns the user' do
          expect(json).not_to be_empty
          expect(json['title']).to eq('Software Engineer')
        end
      end

      context 'when params is not valid' do
        before { post '/api/v1/profile/users', params: { title: '' }, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns a validation error message' do
          expect(response.body).to match(/Validation failed: Title can't be blank/)
        end
      end
    end
  end

  describe 'PUT /api/v1/profile/users/:id' do
    valid_attributes = { title: 'QA' }
    context 'when user not logged in' do
      before { put "/api/v1/profile/users/#{id}", params: valid_attributes }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { put "/api/v1/profile/users/#{id}", params: valid_attributes, headers: @auth_headers }

        it_behaves_like 'successful request'

        it 'update the user' do
          expect(json).not_to be_empty
          expect(json['title']).to eq('QA')
        end
      end

      context 'when params is not valid' do
        before { put "/api/v1/profile/users/#{id}", params: { title: '' }, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns validation error message' do
          expect(response.body).to match(/Validation failed: Title can't be blank/)
        end
      end
    end
  end

  describe 'DELETE /api/v1/profile/users/:id' do
    context 'when user not logged in' do
      before { delete "/api/v1/profile/users/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        delete "/api/v1/profile/users/#{id}", headers: @auth_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'delete the user' do
        expect(User.find_by(id: id)).to eq(nil)
      end
    end
  end
end
