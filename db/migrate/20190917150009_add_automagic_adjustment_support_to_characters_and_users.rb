class AddAutomagicAdjustmentSupportToCharactersAndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :round_checkpoints_override, :integer, default: 0
    add_column :users, :automagic_gold_toggle_override, :integer, default: 0
    add_column :users, :automagic_downtime_toggle_override, :integer, default: 0

    add_column :characters, :automagic_gold_toggle, :integer, default: 0
    add_column :characters, :automagic_downtime_toggle, :integer, default: 0
  end
end
