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
require 'rails_helper'

RSpec.describe Club, type: :model do
  it { should belong_to(:country) }
  it { should belong_to(:city) }
  it { should have_many(:users) }
end
