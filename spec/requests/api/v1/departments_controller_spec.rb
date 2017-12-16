describe Api::V1::DepartmentsController do
  let(:user) { create(:user) }
  let!(:departments){ create_list(:department, 2) }
  let(:id) { departments.first.id }

  describe 'GET /api/v1/departments' do
    context 'when user not logged in' do
      before do
        get '/api/v1/departments'
      end

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get '/api/v1/departments', headers: @auth_headers
      end

      it_behaves_like 'successful request'

      it 'returns departments' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
    end
  end

  describe 'GET /api/v1/departments/:id' do
    context 'when user not logged in' do
      before { get "/api/v1/departments/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get "/api/v1/departments/#{id}", headers: @auth_headers
      end

      context 'when record is found' do
        it_behaves_like 'successful request'

        it 'returns the department' do
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
          expect(response.body).to match(/Couldn't find Department/)
        end
      end
    end
  end

  describe 'POST /api/v1/departments' do
    let(:valid_attributes){ { name: 'Management' } }
    context 'when user not logged in' do
      before { post '/api/v1/departments' }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { post '/api/v1/departments', params: valid_attributes, headers: @auth_headers }

        it 'returns the department' do
          expect(json['name']).to eq('Management')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when params is not valid' do
        before { post '/api/v1/departments', params: { name: '' }, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns a validation failure message' do
          expect(response.body).to match(/Validation failed: Name can't be blank/)
        end
      end
    end
  end

  describe 'PUT /api/v1/departments/:id' do
    context 'when user not logged in' do
      before { put "/api/v1/departments/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { put "/api/v1/departments/#{id}", params: { name: 'Development' }, headers: @auth_headers }

        it_behaves_like 'successful request'

        it 'update the department' do
          expect(json).not_to be_empty
          expect(json['name']).to eq('Development')
        end
      end

      context 'when params is not valid' do
        before { put "/api/v1/departments/#{id}", params: { name: '' }, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns validation error message' do
          expect(response.body).to match(/Validation failed: Name can't be blank/)
        end
      end
    end
  end

  describe 'DELETE /api/v1/departments/:id' do
    context 'when user not logged in' do
      before { delete "/api/v1/departments/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        delete "/api/v1/departments/#{id}", headers: @auth_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'delete the department' do
        expect(Department.find_by(id: id)).to eq(nil)
      end
    end
  end
end
