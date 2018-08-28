class AddNumSecretMissionsToLogEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :log_entries, :num_secret_missions, :integer
  end
end
