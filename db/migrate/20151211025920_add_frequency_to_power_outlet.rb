class AddFrequencyToPowerOutlet < ActiveRecord::Migration
  def change
    add_reference :power_outlets, :frequency, index: true, foreign_key: true
    
    remove_column :power_outlets, :system_code, null: false
    remove_column :power_outlets, :socket_code, null: false
    remove_column :power_outlets, :is_on, default: false, null: false
  end
end
