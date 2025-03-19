class AddInitialData < ActiveRecord::Migration[7.1]
  def up
    ["Россия", "Беларусь", "Казахстан"].each do |country|
     Country.find_or_create_by!(name: country)
    end
    
    @russia = Country.find_by(name: "Россия")

    ["Москва", "Санкт-Петербург"].each do |city|
      City.find_or_create_by!(name: city, country_id: @russia.id)
    end

    @moscow = City.find_by(name: "Москва")

    ["Drive", "Москва", "City squash"].each do |club|
      Club.find_or_create_by!(name: club, country_id: @russia.id, city_id: @moscow.id)
    end

  end

  def down
    Country.delete_all
    City.delete_all
    Club.delete_all
  end

end
