class AddCampaignToLogEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :log_entries, :campaign_id, :integer
  end
end
