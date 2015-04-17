class DmLogEntriesController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  add_crumb('Home', '/')
  before_filter :load_user
  before_filter :load_characters, only: [:new, :create, :edit, :update]
  before_filter :load_log_entry,  only: [:show, :edit, :update, :destroy]

  before_filter() { add_crumb('DM Logs', user_dm_log_entries_path(@user)) }
  before_filter(only: [:new]) { add_crumb "New Log Entry" }
  before_filter(only: [:edit]) { add_crumb "Edit Log Entry" }
  before_filter(only: [:show]) { add_crumb "Show Log Entry" }

  before_filter :redirect_bad_users

  def index
    @search      = @user.dm_log_entries.search(params[:q])
    @log_entries = @search.result(distinct: false).page params[:page]
  end

  def show
  end

  def new
    @log_entry   = @user.dm_log_entries.new
  end

  def create
    @log_entry   = @user.dm_log_entries.build(log_entries_params)

    if @log_entry.save
      redirect_to [@user, DmLogEntry], flash: { notice: "Successfully created log entry #{@log_entry.id}" }
    else
      flash.now[:error] = "Failed to create log_entry #{@log_entry.id}: #{@log_entry.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @log_entry.update_attributes(log_entries_params)
      redirect_to [@user, DmLogEntry], flash: { notice: "Successfully updated log entry #{@log_entry.id}" }
    else
      flash.now[:error] = "Failed to update log_entry #{@log_entry.id}: #{@log_entry.errors.full_messages.join(',')}"
      render :edit
    end
  end


  def destroy
    @log_entry.destroy

    redirect_to [@user, DmLogEntry], flash: { notice: "Successfully deleted DM Log Entry #{@log_entry.id}" }
  end

  protected
    def redirect_bad_users
      unless (@user.publicly_visible)
        redirect_to :root and return unless (@user == current_user)
      end
    end

    def load_user
      @user   = User.find(params[:user_id])
    end

    def load_characters
      @characters  = @user.characters
    end

    def load_log_entry
      @log_entry   = LogEntry.find(params[:id])
    end

    def log_entries_params
      params.require(:dm_log_entry).permit(:adventure_title, :session_num, :date_played, :xp_gained, :gp_gained, :renown_gained, :downtime_gained, :num_secret_missions, :num_magic_items_gained, :desc_magic_items_gained, :location_played, :dm_name, :dm_dci_number, :notes, :character_id)
    end
end
