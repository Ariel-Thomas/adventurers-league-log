class CreateCampaignParticipation < ActiveRecord::Migration
  def change
    create_table :campaign_participations do |t|
      t.integer :campaign_id
      t.integer :character_id
    end
  end
end
