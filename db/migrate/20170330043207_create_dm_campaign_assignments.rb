class CreateDmCampaignAssignments < ActiveRecord::Migration
  def up
    create_table :dm_campaign_assignments do |t|
      t.integer :user_id
      t.integer :campaign_id
    end

    Campaign.all.each do |campaign|
      next unless campaign && campaign.user_id
      next unless User.find_by_id(campaign.user_id)
      DmCampaignAssignment.create!(campaign_id: campaign.id, user_id: campaign.user_id)
    end

    remove_column :campaigns, :user_id, :integer
  end

  def down
    add_column :campaigns, :user_id, :integer
    drop_table :dm_campaign_assignments
  end
end
