class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_code
      t.references :panel_provider, index: true

      t.timestamps
    end
  end
end
