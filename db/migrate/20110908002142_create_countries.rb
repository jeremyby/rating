class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :code
      t.string :short_name
      t.string :full_name
      t.text :intro

      t.timestamps
    end
  end
end
