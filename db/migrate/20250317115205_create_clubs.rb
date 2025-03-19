class CreateClubs < ActiveRecord::Migration[7.1]
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :city_id
      t.integer :country_id

      t.timestamps
    end
  end
end
