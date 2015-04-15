class LogEntriesController < AuthenticationController
  def new
    @character   = Character.find(params[:character_id])
    @log_entry   = @character.log_entries.new
  end

  def create
    @character   = Character.find(params[:character_id])
    @log_entry   = @character.log_entries.build(log_entries_params)

    if @log_entry.save
      redirect_to user_character_path(current_user, @character), flash: { notice: "Successfully created character #{@log_entry.adventure_title}" }
    else
      flash.now[:error] = "Failed to create log_entry #{@log_entry.adventure_title}: #{@log_entry.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
    @character   = Character.find(params[:character_id])
    @log_entry   = LogEntry.find(params[:id])
  end

  def update
    @character   = Character.find(params[:character_id])
    @log_entry   = LogEntry.find(params[:id])

    if @log_entry.update_attributes(log_entries_params)
      redirect_to user_character_path(current_user, @character), flash: { notice: "Successfully updated character #{@log_entry.adventure_title}" }
    else
      flash.now[:error] = "Failed to update log_entry #{@log_entry.adventure_title}: #{@log_entry.errors.full_messages.join(',')}"
      render :edit
    end
  end


  def destroy
    @character   = Character.find(params[:character_id])
    @log_entry   = LogEntry.find(params[:id])
    @log_entry.destroy

    redirect_to user_character_path(current_user, @character), flash: { notice: "Successfully deleted #{@log_entry.adventure_title}" }
  end

  protected

    def log_entries_params
      params.require(:log_entry).permit(:adventure_title, :session_num, :date_played, :xp_gained, :gp_gained, :renown_gained, :downtime_gained, :num_magic_items_gained, :desc_magic_items_gained, :location_played, :dm_name, :dm_dci_number)
    end
end
