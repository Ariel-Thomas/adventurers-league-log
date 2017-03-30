class CreateDmCampaignAssignments < ActiveRecord::Migration
  def change
    create_table :dm_campaign_assignments do |t|
      t.integer :user_id
      t.integer :campaign_id
    end

    Campaign.all.each do |campaign|
      DmCampaignAssignment.create!(campaign: campaign, user: campaign.user)
    end

    remove_column :campaigns, :user_id, :integer
  end
end
