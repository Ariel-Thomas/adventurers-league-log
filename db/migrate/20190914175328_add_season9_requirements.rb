class AddSeason9Requirements < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :round_checkpoints, :integer, default: 0
    add_column :log_entries, :milestones_gained, :integer
    add_column :log_entries, :log_format, :integer, default: 0

    puts("BEGIN SET LOG FORMAT")
    total_num = LogEntry.all.count
    one_percent = LogEntry.all.count / 100
    puts("Total LogEntries #{total_num}")

    LogEntry.all.each_with_index do |le, i|
      if le.old_format
        le.update!(log_format: 0)
      else
        le.update!(log_format: 1)
      end

      print("#{i / one_percent}% ") if(i % one_percent == 0)
    end
    puts("END SET LOG FORMAT")

  end
end
