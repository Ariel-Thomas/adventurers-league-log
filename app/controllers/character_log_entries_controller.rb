class CharacterLogEntriesController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:show]

  add_crumb('Home', '/')
  before_filter :load_character
  before_filter :load_log_entry, only: [:show, :edit, :update, :destroy]

  before_filter { add_crumb @character.name, user_character_path(@character.user, @character) }

  before_filter(only: [:new]) { add_crumb "New Log Entry" }
  before_filter(only: [:show, :edit]) { add_crumb @log_entry.adventure_title, user_character_character_log_entry_path(@character.user, @character, @log_entry) }

  def show
    unless (@character.publicly_visible)
      redirect_to :root and return unless (@character.user == current_user)
    end
  end

  def new
    @user        = current_user
    @log_entry   = @character.character_log_entries.new
  end

  def create
    @user        = current_user
    @log_entry   = @character.character_log_entries.build(log_entries_params)

    if @log_entry.save
      redirect_to user_character_path(current_user, @character), flash: { notice: "Successfully created character #{@log_entry.adventure_title}" }
    else
      flash.now[:error] = "Failed to create log_entry #{@log_entry.adventure_title}: #{@log_entry.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @log_entry.update_attributes(log_entries_params)
      redirect_to user_character_path(current_user, @character), flash: { notice: "Successfully updated character #{@log_entry.adventure_title}" }
    else
      flash.now[:error] = "Failed to update log_entry #{@log_entry.adventure_title}: #{@log_entry.errors.full_messages.join(',')}"
      render :edit
    end
  end


  def destroy
    @log_entry.destroy

    redirect_to user_character_path(current_user, @character), flash: { notice: "Successfully deleted #{@log_entry.adventure_title}" }
  end

  protected
    def load_character
      @character   = Character.find(params[:character_id])
    end

    def load_log_entry
      @log_entry   = LogEntry.find(params[:id])
    end

    def log_entries_params
      params.require(:character_log_entry).permit(:adventure_title, :session_num, :date_played, :xp_gained, :gp_gained, :renown_gained, :downtime_gained, :num_secret_missions, :num_magic_items_gained, :desc_magic_items_gained, :location_played, :dm_name, :dm_dci_number, :notes)
    end
end
