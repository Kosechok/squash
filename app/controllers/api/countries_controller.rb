class Api::CountriesController < ApplicationController

	def index
		@all = Country.all
		serialized_countries = CountrySerializer.new(@all).serializable_hash[:data].map { |country| country[:attributes] }
		render json: { code: 0, countries: serialized_countries }
	end
end
