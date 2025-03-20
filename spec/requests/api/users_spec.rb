require 'rails_helper'

RSpec.describe "Users", type: :request do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get api_users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  path '/api/user/signup' do
    post('register user') do
      tags 'User Registration'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              password: { type: :string }
            },
            required: ['name', 'email', 'password']
          }
        },
        required: ['user']
      }

      response(200, 'successful') do
      	schema type: :object,
               properties: {
                 code: { type: :integer },
                 token: { type: :string },
                 user: { 
                   type: :object,
                   properties: {
                     category: { type: :string },
                     city: { type: :string },
                     club: { type: :string },
                     country: { type: :string },
                     date_of_birth: { type: :string },
                     email: { type: :string },
                     email_verified: { type: :boolean },
                     gender: { type: :string },
                     id: { type: :integer },
                     name: { type: :string },
                     position: { type: :string },
                     rating: { type: :string },
                     surname: { type: :string }
                   }
                 }
               }
        let(:user) { { user: { name: 'John', email: '1e33e33e32bla-bla@bla.ru', password: '12345678' } } }

        it 'returns a successful registration response with token and user data' do
          post '/api/user/signup', params: user.to_json, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

          # Check response status
          expect(response).to have_http_status(200)

          # Check response body
          json_response = JSON.parse(response.body)
          expect(json_response['code']).to eq(0)
          expect(json_response['token']).to be_a(String)
          expect(json_response['user']['email']).to eq('1e33e33e32bla-bla@bla.ru')
          expect(json_response['user']['name']).to eq('John') # So that the name field is initially nil
          expect(json_response['user']['email_verified']).to eq(false)
        end
      end

      # response(422, 'unprocessable entity') do
      #   let(:user) { { user: { name: '', email: 'invalid_email', password: '123' } } }

      #   it 'returns an error when user registration fails' do
      #     post '/api/signup', params: user.to_json, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

      #     expect(response).to have_http_status(422)

      #     json_response = JSON.parse(response.body)
      #     expect(json_response['status']['message']).to include("User couldn't be created successfully.")
      #   end
      # end
    end
  end

end
