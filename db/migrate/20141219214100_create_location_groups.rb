class CreateLocationGroups < ActiveRecord::Migration
  def change
    create_table :location_groups do |t|
      t.string :name
      t.references :country, index: true
      t.references :panel_provider, index: true

      t.timestamps
    end
  end
end
