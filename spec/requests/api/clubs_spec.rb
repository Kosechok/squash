require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'api/clubs', type: :request do
  let!(:country) { Country.create(name: "Россия") } 
  let!(:city1) { City.create(name: "Москва", country_id: country.id) }
  let!(:city2) { City.create(name: "Санкт-Петербург", country_id: country.id) }
  let!(:club1) { Club.create(name: "Drive", country_id: country.id, city_id: city1.id)}
  let!(:club2) { Club.create(name: "Москва", country_id: country.id, city_id: city1.id)}

  path '/api/clubs' do
    get('List clubs') do
      tags 'Clubs', 'without Auth'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 code: { type: :integer },
                 clubs: { 
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       country_name: { type: :string },
                       city_name: { type: :string }
                     }
                   }
                 }
               }

        run_test! do |response|
          json_response = JSON.parse(response.body)

          # RSpec-проверки внутри Swagger API-теста
          expect(json_response["code"]).to eq(0)
          expect(json_response["clubs"]).to be_an(Array)
          expect(json_response["clubs"].size).to eq(2)

          expect(json_response["clubs"][0]).to include(
            "country_name" => "Россия",
            "id" => club1.id,
            "city_name" => "Москва",
            "name" => "Drive"
          )

          expect(json_response["clubs"][1]).to include(
            "country_name" => "Россия",
            "id" => club2.id,
            "city_name" => "Москва",
            "name" => "Москва"
          )
        end
      end
    end
  end
end


# require 'swagger_helper'

# RSpec.describe 'api/clubs', type: :request do

#   path '/api/clubs' do

#     get('list clubs') do
#       response(200, 'successful') do
#         produces 'application/json'

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end
#   end
# end
