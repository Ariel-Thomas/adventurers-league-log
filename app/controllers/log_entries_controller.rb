class LogEntriesController < AuthenticationController
  def new
    @character   = Character.find(params[:character_id])
    @log_entry   = @character.log_entries.new
  end
end
