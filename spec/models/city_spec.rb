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
require 'rails_helper'

RSpec.describe City, type: :model do
  it { should belong_to(:country) }
  it { should have_many(:clubs) }
  it { should have_many(:users) }

  let(:country) { Country.create(name: "Россия") }
  let(:city) { City.create(name: "Москва", country: country) }
  # let(:user) { User.create()}  

  it "создает город и связывает с страной" do
    expect(city.country).to eq(country)
  end  
end
