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
# require 'rails_helper'
# require 'error/custom_error'

# RSpec.describe User, type: :model do
#   # describe 'associations' do
#   #   it { should belong_to(:country).optional }
#   #   it { should belong_to(:city).optional }
#   #   it { should belong_to(:club).optional }
#   # end
#   # it { should belong_to(:city) }  

#  describe 'validations' do
#     let!(:existing_user) { User.create(email: "test@example.com", password: "password123") } 
#     let(:user) { User.new(email: "new@example.com", password: "password123") }
#     let(:user_same_email) { User.new(email: "test@example.com", password: "password123") }
#     let(:user_short_password) { User.new(email: "short@example.com", password: "pa") }
#     let(:user_long_password) { User.new(email: "long@example.com", password: "p" * 80) } # Длинный пароль (130 символов)

#     it "должен быть валидным с корректными данными" do
#       expect(user).to be_valid
#     end

#     it "не должен быть валидным, если email уже используется" do
#       expect {user_same_email}.to raise_error(Error::EmailExists)
#       # expect(user_same_email.errors[:email]).to include("has already been taken")
#     end

#     it "не должен быть валидным, если пароль слишком короткий" do
#       expect {user_same_email}.to raise_error(Error::PasswordTooShort)
#       # expect(user_short_password.errors[:password]).to include("is too short (minimum is 6 characters)")
#     end

#     it "не должен быть валидным, если пароль слишком длинный" do
#       expect {user_same_email}.to raise_error(Error::PasswordTooLong)
#       # expect(user_long_password.errors[:password]).to include("is too long")
#     end
#   end
# end