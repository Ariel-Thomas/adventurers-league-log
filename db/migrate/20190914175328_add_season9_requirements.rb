class AddSeason9Requirements < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :round_checkpoints, :integer, default: 0
    add_column :log_entries, :milestones_gained, :integer
    add_column :log_entries, :log_format, :integer, default: 0

    puts("BEGIN SET LOG FORMAT")
    total_num = LogEntry.all.count
    one_percent = LogEntry.all.count / 100
    puts("Total LogEntries #{total_num}")

    LogEntry.find_in_batches.with_index do |group, batch|
      group.each{ |le|
        if le.old_format
          le.update!(log_format: 0)
        else
          le.update!(log_format: 1)
        end
      }

      puts "Processing group #{batch} / #{total_num / 1000 + 1}"
    end
    puts("END SET LOG FORMAT")

  end
end
