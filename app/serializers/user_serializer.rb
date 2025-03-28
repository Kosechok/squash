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
class UserSerializer# < ActiveModel::Serializer

  include JSONAPI::Serializer

  attributes :id, :name, :surname, :gender, :category, :rating, :position, :date_of_birth#, :city, :country, :club#, :email_verified


  attribute :email, if: -> (record, params) { !params || !params[:hide_details] }

  # attribute :email_verified do |user|
  #    !user.confirmed_at.nil?
  # end 
  # attribute :email do |object, params|
  #   object.email unless params && params[:hide_details]
  # end
  attribute :email_verified, if: -> (record, params) { !params || !params[:hide_details] } do |user|
    !user.confirmed_at.nil?
  end

  attribute :city do |user|
    user&.city&.name
  end  

  attribute :country do |user|
    user&.country&.name
  end  

  attribute :club do |user|
    user&.club&.name
  end


end
