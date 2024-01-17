require 'rails_helper'

RSpec.describe 'Sessions Endpoints' do
  describe 'Register as a new User' do
    describe 'POST /api/v0/sessions', :vcr do
      describe 'Happy Path' do
        it 'allows a registered User to log in and creates a new Session', :vcr do
          user = create(:user)
          login = {
            email: user.email,
            password: "Password"
          }
          post '/api/v0/sessions', params: login.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
          expect(request.url).to eq("http://www.example.com/api/v0/sessions")
          expect(response.status).to eq(200)
          expect(response).to have_http_status(:ok)
          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:data][:type]).to eq("users")
          expect(results[:data][:attributes][:email]).to eq(user.email)
          expect(results[:data][:attributes][:api_key]).to eq(user.api_key)
        end
      end  
      describe 'Sad Path', :vcr do
        it 'fails to log in with invalid credentials' do
          user = create(:user)
          login = {
            email: user.email,
            password: "Incorrect Password"
          }
          post '/api/v0/sessions', params: login.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } 
          expect(response.status).to eq(401)
          expect(response).to have_http_status(:unauthorized)
          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:errors].first).to eq('Invalid email or password')
        end
      end
    end
  end
end