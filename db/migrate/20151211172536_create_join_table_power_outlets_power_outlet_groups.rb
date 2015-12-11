class CreateJoinTablePowerOutletsPowerOutletGroups < ActiveRecord::Migration
  def change
    create_join_table :power_outlets,
                      :power_outlet_groups,
                      column_options: {null: false} do |t|
      t.index [:power_outlet_group_id, :power_outlet_id],
              unique: true,
              name: 'join_index_power_outlet_groups_to_outlets'
      t.index [:power_outlet_id, :power_outlet_group_id],
              unique: true,
              name: 'join_index_power_outlets_to_groups'
    end
  end
end
