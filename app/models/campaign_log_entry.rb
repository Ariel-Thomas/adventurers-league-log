class CampaignLogEntry < LogEntry
  belongs_to :campaign

  def user
    return campaign.user if campaign
    super
  end

  def is_campaign_log_entry?
    true
  end
end
