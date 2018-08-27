class AddStyleToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :campaign_style, :integer, default: 1
    add_column :campaigns, :campaign_log_entry_style, :integer, default: 1
  end
end
