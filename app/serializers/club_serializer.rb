# == Schema Information
#
# Table name: clubs
#
#  id         :integer          not null, primary key
#  name       :string
#  city_id    :integer
#  country_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ClubSerializer
  include JSONAPI::Serializer

  attributes :name, :id, :country_name, :city_name

  attribute :country_name do |club|
    club.country&.name
  end  

  attribute :city_name do |club|
    club.city&.name
  end      

end
