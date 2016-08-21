class AddDateDmedToLogEntries < PhilColumns::Seed

  envs :test, :development, :production
  tags :default

  def up
    DmLogEntry.all.each do |log_entry|
      log_entry.update!(date_dmed: log_entry.date_played, date_played: nil)
    end
  end

  def down
  end

end
