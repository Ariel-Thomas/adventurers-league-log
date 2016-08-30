class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :user_id

      t.string :name
      t.string :token
      t.boolean :users_can_join,   default: false, null: false
      t.boolean :publicly_visible, default: false, null: false
    end
  end
end
