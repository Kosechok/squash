# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CountrySerializer
  include JSONAPI::Serializer

  attributes :id, :name

end
