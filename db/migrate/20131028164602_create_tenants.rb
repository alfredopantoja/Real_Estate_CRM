class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string  :name
      t.string  :email
      t.string  :phone
      t.integer :building_id

      t.timestamps
    end
    add_index :tenants, :building_id
  end
end
