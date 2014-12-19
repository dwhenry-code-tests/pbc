class CreateTargetGroups < ActiveRecord::Migration
  def change
    create_table :target_groups do |t|
      t.string :name
      t.string :external_id
      t.references :parent, index: true
      t.string :secret_code
      t.references :country, index: true
      t.references :panel_provider, index: true

      t.timestamps
    end

    add_index :target_groups, :secret_code
  end
end
