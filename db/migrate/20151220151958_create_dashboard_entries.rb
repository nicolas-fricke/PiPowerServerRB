class CreateDashboardEntries < ActiveRecord::Migration
  def change
    create_table :dashboard_entries do |t|
      t.references :item, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
