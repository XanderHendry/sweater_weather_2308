require 'rails_helper'

RSpec.describe 'User Endpoints' do
  describe 'Register as a new User' do
    describe 'POST /api/v0/users' do
      describe 'Happy Path' do
        it 'creates a new user and returns a valid response' do
          user = {
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password"
          }
          post '/api/v0/users', params: user.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
          expect(request.url).to eq("http://www.example.com/api/v0/users")
          expect(response.status).to eq(201)
          expect(response).to have_http_status(:created)
          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:data][:type]).to eq("users")
          expect(results[:data][:attributes][:email]).to eq("whatever@example.com")
          expect(results[:data][:attributes][:api_key]).to be_a(String)
        end
      end  
      describe 'Sad Path' do
        it 'fails to create a new user and returns an error response' do
          user = {
            email: 'sad@example.com',
            password: 'password',
            password_confirmation: 'wrong_password'
          }
          
          post '/api/v0/users', params: user.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } 
          
          expect(response.status).to eq(422)
          expect(response).to have_http_status(:unprocessable_entity)
          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:errors].first).to eq('Password confirmation doesn\'t match Password')
        end
      end
    end
  end
end
