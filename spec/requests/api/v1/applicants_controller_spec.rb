describe Api::V1::ApplicantsController do
  let(:user) { create(:user) }
  let!(:applicants){ create_list(:applicant, 2) }
  let(:id){ applicants.first.id }

  describe 'GET /api/v1/applicants' do
    context 'when user not logged in' do
      before { get '/api/v1/applicants' }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get '/api/v1/applicants', headers: @auth_headers
      end

      it_behaves_like 'successful request'

      it 'returns applicants' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
    end
  end

  describe 'GET /api/v1/departments/:id' do
    context 'when user not logged in' do
      before { get "/api/v1/applicants/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        get "/api/v1/applicants/#{id}", headers: @auth_headers
      end

      context 'when record is found' do
        it_behaves_like 'successful request'

        it 'returns the applicant' do
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
          expect(response.body).to match(/Couldn't find Applicant/)
        end
      end
    end
  end

  describe 'POST /api/v1/applicants' do
    valid_attributes = {
      name: 'Pirun Seng',
      email: FFaker::Internet.email,
      phone: FFaker::PhoneNumber.short_phone_number,
      interview_date: FFaker::Time.datetime
    }
    context 'when user not logged in' do
      before { post '/api/v1/applicants', params: valid_attributes }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { post '/api/v1/applicants', params: valid_attributes, headers: @auth_headers }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'returns the applicant' do
          expect(json).not_to be_empty
          expect(json['name']).to eq('Pirun Seng')
        end
      end

      context 'when params is not valid' do
        invalid_attributes = {
          name: 'Pirun Seng',
          phone: FFaker::PhoneNumber.short_phone_number,
          interview_date: FFaker::Time.date
        }
        before { post '/api/v1/applicants', params: invalid_attributes, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns a validation error message' do
          expect(response.body).to match(/Validation failed: Email can't be blank/)
        end
      end
    end
  end

  describe 'PUT /api/v1/applicants/:id' do
    valid_attributes = { interview_status: 'shortlist' }
    context 'when user not logged in' do
      before { put "/api/v1/applicants/#{id}", params: valid_attributes }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
      end

      context 'when params is valid' do
        before { put "/api/v1/applicants/#{id}", params: valid_attributes, headers: @auth_headers }

        it_behaves_like 'successful request'

        it 'update the applicant' do
          expect(json).not_to be_empty
          expect(json['interview_status']).to eq('shortlist')
        end
      end

      context 'when params is not valid' do
        before { put "/api/v1/applicants/#{id}", params: { interview_status: 'done' }, headers: @auth_headers }

        it_behaves_like 'unprocessable entity'

        it 'returns validation error message' do
          expect(response.body).to match(/Validation failed: Interview result can't be blank/)
        end
      end
    end
  end

  describe 'DELETE /api/v1/applicants/:id' do
    context 'when user not logged in' do
      before { delete "/api/v1/applicants/#{id}" }

      it_behaves_like 'unauthorized'
    end

    context 'when user logged in' do
      before do
        sign_in(user)
        delete "/api/v1/applicants/#{id}", headers: @auth_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'delete the applicant' do
        expect(Applicant.find_by(id: id)).to eq(nil)
      end
    end
  end
end
