class CreatePowerOutlets < ActiveRecord::Migration
  def change
    create_table :power_outlets do |t|
      t.string :name, null: false
      t.string :location
      t.string :system_code, null: false
      t.integer :socket_code, null: false
      t.boolean :is_on, default: false, null: false

      t.timestamps null: false
    end
  end
end
