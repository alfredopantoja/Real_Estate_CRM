class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :address
      t.integer :zip_code
      t.text :description
      t.integer :landlord_id

      t.timestamps
    end
    add_index :buildings, :landlord_id
  end
end
