# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  name                   :string
#  surname                :string
#  gender                 :string
#  category               :string
#  rating                 :integer
#  position               :integer
#  city_id                :integer
#  country_id             :integer
#  club_id                :integer
#  date_of_birth          :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:country).optional }
    it { should belong_to(:city).optional }
    it { should belong_to(:club).optional }
  end
  # it { should belong_to(:city) }  

  describe 'validations' do
    let(:country) { Country.create(name: "Россия") }
    let(:user) { User.new(email: "test@example.com", password: "password123") }

    it "должен быть допустимым без страны" do
      expect(user).to be_valid
    end

    it "должен быть допустимым с существующей страной" do
      user.country = country
      expect(user).to be_valid
    end
  end  
end
