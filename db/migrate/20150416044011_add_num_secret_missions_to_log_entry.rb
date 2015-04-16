class AddNumSecretMissionsToLogEntry < ActiveRecord::Migration
  def change
    add_column :log_entries, :num_secret_missions, :integer
  end
end
