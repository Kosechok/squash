class CitySerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :id, :country_name

  attribute :country_name do |city|
    city.country&.name
  end  

end