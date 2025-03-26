require 'rails_helper'

RSpec.describe "Users", type: :request do
  # Путь для регистрации пользователя
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
                 message: { type: :string },
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

          expect(response).to have_http_status(200)
          json_response = JSON.parse(response.body)
          expect(json_response['code']).to eq(0)
          expect(json_response['token']).to be_a(String)
          expect(json_response['user']['email']).to eq('1e33e33e32bla-bla@bla.ru')
          expect(json_response['user']['name']).to eq('John')
          expect(json_response['user']['email_verified']).to eq(false)
        end

        let(:user_same_mail) { { user: { name: 'Kirh', email: '1e33e33e32bla-bla@bla.ru', password: '12345678' } } }
        it 'returns an error code for duplicate email' do
          post '/api/user/signup', params: user.to_json, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          post '/api/user/signup', params: user_same_mail.to_json, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

          expect(response).to have_http_status(200)
          json_response = JSON.parse(response.body)
          expect(json_response['code']).to eq(100)
          expect(json_response['message']).to eq('e-mail is busy')
        end

        let(:user_short_pass) { { user: { name: 'Kirh', email: '1ea-bla@bla.ru', password: '1' } } }
        it 'returns an error code for short password' do
          post '/api/user/signup', params: user_short_pass.to_json, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

          expect(response).to have_http_status(200)
          json_response = JSON.parse(response.body)
          expect(json_response['code']).to eq(101)
          expect(json_response['message']).to eq('password too short, minimun is 2')
        end

        let(:user_long_pass) { { user: { name: 'Kirh', email: '1ea-bla@bla.ru', password: '1' * 100 } } }
        it 'returns an error code for long password' do
          post '/api/user/signup', params: user_long_pass.to_json, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

          expect(response).to have_http_status(200)
          json_response = JSON.parse(response.body)
          expect(json_response['code']).to eq(102)
          expect(json_response['message']).to eq('password too long, maximum is 80')
        end
      end
    end
  end

  # Путь для входа пользователя
  path '/api/user/login' do
    post('login user') do
      tags 'User Login'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: ['email', 'password']
          }
        },
        required: ['user']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 code: { type: :integer },
                 token: { type: :string }
               }

        let(:user) { create(:user) }

        context 'with valid credentials' do
          it 'returns a JSON with a token' do
            post '/api/user/login', params: { user: { email: user.email, password: user.password } }, as: :json

            expect(response).to have_http_status(:ok)
            json_response = JSON.parse(response.body)
            expect(json_response['code']).to eq(0)
            expect(json_response['token']).not_to be_nil
          end
        end

        context 'with invalid credentials' do
          it 'returns a JSON with an error message' do
            post '/api/user/login', params: { user: { email: user.email, password: 'wrongpassword' } }, as: :json

            expect(response).to have_http_status(:ok)
            json_response = JSON.parse(response.body)
            expect(json_response['code']).to eq(110)
            expect(json_response['message']).to eq('Неверный email или пароль')
          end
        end
      end
    end
  end

  # Путь для обновления данных пользователя
  path '/api/users' do
    patch('update user') do
      tags 'User Update'
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
              surname: { type: :string },
              gender: { type: :string },
              category: { type: :string },
              rating: { type: :string },
              position: { type: :string },
              date_of_birth: { type: :string },
              city_id: { type: :integer},
              country_id: { type: :integer},
              club_id: { type: :integer} 
            },
            required: [] 
          }
        },
        required: ['user']
      }

      response(200, 'successful') do
        let(:user) { create(:user) }
        let(:auth_headers) do
          post '/api/user/login', params: { user: { email: user.email, password: user.password } }, as: :json
          json_response = JSON.parse(response.body)
          { 'Authorization' => "Bearer #{json_response['token']}" }
        end

        context 'with valid data and valid JWT' do
          it 'updates user data successfully' do
            patch '/api/user/signup',
                  headers: auth_headers,
                  params: {
                    user: {
                      name: 'New Name',
                      email: 'new.email@example.com',
                      surname: user.surname,
                      gender: user.gender,
                      category: user.category,
                      rating: user.rating,
                      position: user.position,
                      date_of_birth: user.date_of_birth
                    }
                  }, as: :json

            expect(response).to have_http_status(:ok)
            json_response = JSON.parse(response.body)
            expect(json_response['user']['name']).to eq('New Name')
            expect(json_response['user']['email']).to eq('new.email@example.com')
            expect(json_response['user']['surname']).to eq(user.surname)
            expect(json_response['user']['category']).to eq(user.category)
            expect(json_response['user']['gender']).to eq(user.gender)
            expect(json_response['user']['rating']).to eq(user.rating)
            expect(json_response['user']['position']).to eq(user.position)
            expect(Date.parse(json_response['user']['date_of_birth'])).to eq(user.date_of_birth)
          end
        end

        context 'with invalid data and valid JWT' do
          it 'returns validation errors' do
            patch '/api/user/signup',
                  headers: auth_headers,
                  params: {
                    user: {
                      email: 'invalid_email'
                    }
                  }, as: :json

            expect(response).to have_http_status(:ok)
            json_response = JSON.parse(response.body)
            expect(json_response['code']).to eq(104)
            expect(json_response['message']).to eq('please provide email in correct format')
          end

          it 'unknown category' do
            patch '/api/user/signup',
              headers: auth_headers,
              params: {
                user: {
                  category: 'C25'
                }
              }, as: :json
puts "--------------------"
puts JSON.pretty_generate(JSON.parse(response.body))
puts "--------------------"
            expect(response).to have_http_status(:ok)
            json_response = JSON.parse(response.body)
            expect(json_response['code']).to eq(105)
            expect(json_response['message']).to eq('unkown category')

          end

        end

        context 'with valid data and invalid JWT' do
          it 'returns unauthorized error' do
            patch '/api/user/signup',
                  headers: { 'Authorization' => 'Bearer invalid_token' },
                  params: {
                    user: {
                      name: 'New Name'
                    }
                  }, as: :json

            expect(response).to have_http_status(:ok)
            json_response = JSON.parse(response.body)
            expect(json_response['code']).to eq(150)
            expect(json_response['message']).to eq('wrong autorization, please login')
          end
        end
      end
    end
  end
end