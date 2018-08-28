class CreateCampaignParticipation < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_participations do |t|
      t.integer :campaign_id
      t.integer :character_id
    end
  end
end
