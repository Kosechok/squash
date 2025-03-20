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
class Club < ApplicationRecord
	belongs_to :country
	belongs_to :city
	has_many :users
end
