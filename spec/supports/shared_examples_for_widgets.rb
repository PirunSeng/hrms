shared_examples 'unauthorized' do
  it 'returns status code 401' do
    expect(response).to have_http_status(401)
  end
end

shared_examples 'successful request' do
  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end

shared_examples 'unprocessable entity' do
  it 'returns status code 422' do
    expect(response).to have_http_status(422)
  end
end
