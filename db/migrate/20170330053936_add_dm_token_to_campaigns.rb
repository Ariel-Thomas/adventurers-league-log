class AddDmTokenToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :dm_token, :string
    add_column :campaigns, :dms_can_join, :boolean, default: false, null: false
  end
end
