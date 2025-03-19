class Api::CitiesController < ApplicationController

	def index
		@all = City.all
		# render json: @all
		serialized_cities = CitySerializer.new(@all).serializable_hash[:data].map { |city| city[:attributes] }
		render json: { code: 0, cities: serialized_cities }
	end

end
