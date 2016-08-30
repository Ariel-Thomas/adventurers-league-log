class AddCampaignToLogEntry < ActiveRecord::Migration
  def change
    add_column :log_entries, :campaign_id, :integer
  end
end
