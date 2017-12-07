describe Api::V1::DepartmentsController do
  let(:user) { create(:user) }
  let!(:departments){ create_list(:department, 2) }

  describe 'GET #index' do
    context 'when user not logged in' do
      before do
        get '/api/v1/departments'
      end

      it 'should return status 401 unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get '/api/v1/departments', params: @auth_headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns departments' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
    end
  end
end
