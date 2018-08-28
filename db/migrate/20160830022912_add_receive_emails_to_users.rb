class AddReceiveEmailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :receive_emails, :boolean
  end
end
