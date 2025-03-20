# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  country_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CitySerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :id, :country_name

  attribute :country_name do |city|
    city.country&.name
  end  

end
