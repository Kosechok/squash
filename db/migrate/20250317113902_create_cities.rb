class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :country_id

      t.timestamps
    end
  end
end
