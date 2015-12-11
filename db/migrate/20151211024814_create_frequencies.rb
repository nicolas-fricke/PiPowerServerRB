class CreateFrequencies < ActiveRecord::Migration
  def change
    create_table :frequencies do |t|
      t.string :system_code, null: false
      t.integer :socket_code, null: false
      t.boolean :is_on, default: false, null: false

      t.timestamps null: false
    end
  end
end
