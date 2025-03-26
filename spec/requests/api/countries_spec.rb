require 'swagger_helper'

RSpec.describe 'api/countries', type: :request do

  let!(:country) { Country.create(name: "Россия") } 
  let!(:country2) { Country.create(name: "Беларусь") } 

  path '/api/countries' do

    get('list countries') do
      tags 'without Auth'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 code: { type: :integer },
                 countries: { 
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string }
                     }
                   }
                 }
               }

        run_test! do |response|
          json_response = JSON.parse(response.body)

          expect(json_response["code"]).to eq(0)
          expect(json_response["countries"]).to be_an(Array)
          expect(json_response["countries"].size).to eq(2)

          expect(json_response["countries"][0]).to include(
            "name" => "Россия",
            "id" => country.id
          )
          expect(json_response["countries"][1]).to include(
            "name" => "Беларусь",
            "id" => country2.id
          )          
        end
      end
    end
  end
end
