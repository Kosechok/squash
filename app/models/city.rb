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
class City < ApplicationRecord

	belongs_to :country
	has_many :clubs 
	has_many :users
end
