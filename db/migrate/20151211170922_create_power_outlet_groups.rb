class CreatePowerOutletGroups < ActiveRecord::Migration
  def change
    create_table :power_outlet_groups do |t|
      t.string :name, null: false
      t.string :description
      t.string :permalink

      t.timestamps null: false
    end
  end
end
