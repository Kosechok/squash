require 'swagger_helper'

RSpec.describe 'api/cities', type: :request do

  let!(:country) { Country.create(name: "Россия") } 
  let!(:city1) { City.create(name: "Москва", country_id: country.id) }
  let!(:city2) { City.create(name: "Санкт-Петербург", country_id: country.id) }

  path '/api/cities' do

    get('list cities') do
      tags 'Cities', 'without Auth'
      produces 'application/json'      
      response(200, 'successful') do

        schema type: :object,
               properties: {
                 code: { type: :integer },
                 cities: { 
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       country_name: { type: :string }
                     }
                   }
                 }
               }

        run_test! do |response|
          json_response = JSON.parse(response.body)

          # RSpec-проверки внутри Swagger API-теста
          expect(json_response["code"]).to eq(0)
          expect(json_response["cities"]).to be_an(Array)
          expect(json_response["cities"].size).to eq(2)

          expect(json_response["cities"][0]).to include(
            "country_name" => "Россия",
            "id" => city1.id,
            "name" => "Москва"
          )

          expect(json_response["cities"][1]).to include(
            "country_name" => "Россия",
            "id" => city2.id,
            "name" => "Санкт-Петербург"
          )
        end
      end
    end
  end
end
