class ClubSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :id, :country_name, :city_name

  attribute :country_name do |club|
    club.country&.name
  end  

  attribute :city_name do |club|
    club.city&.name
  end      

end