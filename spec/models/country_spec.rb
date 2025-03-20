# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Country, type: :model do
  it { should have_many(:cities) }
  it { should have_many(:clubs) }
  it { should have_many(:users) }
end
