# :nodoc:
class CharacterLogEntriesController < LogEntriesController
  skip_before_action :authenticate_user!, only: [:show]

  add_crumb('Home', '/')
  before_filter :load_user
  before_filter :load_character
  before_filter :build_log_entry, only: [:create]
  before_filter :load_log_entry, only: [:show, :edit, :update, :destroy]
  before_filter :load_player_dms, only: [:new, :create, :edit, :update]

  before_filter do
    add_crumb @character.name,
              user_character_path(@character.user, @character)
  end

  before_filter(only: [:new]) { add_crumb 'New Game Log Entry', '#' }
  before_filter(only: [:edit]) { add_crumb 'Edit Log Entry' }
  before_filter(only: [:show]) { add_crumb 'Show Log Entry' }

  def show
    authorize @log_entry
    @magic_items = @log_entry.magic_items
  end

  def new
    @log_entry = @character.character_log_entries.new
    @log_entry.characters = [@character]
    authorize @log_entry
    @magic_items = [MagicItem.new]
    @magic_item_count = 0
  end

  def create
    authorize @log_entry
    manage_player_dms

    if @log_entry.save
      redirect_to user_character_path(current_user, @character, q: params[:q]),
                  flash: { notice: 'Successfully created log entry '\
                                   "#{@log_entry.adventure_title}" }
    else
      flash.now[:error] = log_entry_error_message 'create'
      render :new, q: params[:q]
    end
  end

  def edit
    authorize @log_entry
    @magic_items = [MagicItem.new] + @log_entry.magic_items
    @magic_item_count = @log_entry.magic_items.count
  end

  def update
    authorize @log_entry
    manage_player_dms

    if @log_entry.update_attributes(log_entries_params)
      redirect_to user_character_path(current_user, @character, q: params[:q]),
                  flash: { notice: 'Successfully updated log entry '\
                                   "#{@log_entry.adventure_title}" }
    else
      flash.now[:error] = log_entry_error_message 'update'
      render :edit, q: params[:q]
    end
  end

  def destroy
    authorize @log_entry
    @log_entry.destroy

    redirect_to user_character_path(current_user, @character, q: params[:q]),
                flash: { notice: 'Successfully deleted '\
                                 "#{@log_entry.adventure_title}" }
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_character
    @character   = Character.find(params[:character_id])
  end

  def load_log_entry
    @log_entry   = LogEntry.find(params[:id])
  end

  def build_log_entry
    @log_entry = @character.character_log_entries.build(log_entries_params)
    @log_entry.characters = [@character]
  end

  def load_player_dms
    @player_dms = @user.player_dms.all
  end

  def manage_player_dms
    if params[:character_log_entry][:player_dm_id] &&
       params[:character_log_entry][:player_dm_id] != ''
      load_existing_player_dm
    elsif params[:character_log_entry][:dm_dci_number]
      create_player_dm
    end
  end

  def load_existing_player_dm
    player_dm_id = params[:character_log_entry][:player_dm_id]
    @player_dm = @user.player_dms.find(player_dm_id)

    params[:character_log_entry][:dm_name]       = @player_dm.name
    params[:character_log_entry][:dm_dci_number] = @player_dm.dci
  end

  def create_player_dm
    dm_name = params[:character_log_entry][:dm_name]
    dm_dci_number = params[:character_log_entry][:dm_dci_number]
    @player_dm = @user.player_dms.find_by(dci: dm_dci_number)

    unless @player_dm
      @player_dm = @user.player_dms.create!(
        name: dm_name,
        dci: dm_dci_number
      )
    end

    params[:character_log_entry][:player_dm_id] = @player_dm.id
  end

  def log_entries_params
    params.require(:character_log_entry)
          .permit(:adventure_title, :session_num, :date_played,
                  :xp_gained, :gp_gained, :renown_gained,
                  :downtime_gained, :num_secret_missions,
                  :location_played, :dm_name, :dm_dci_number,
                  :player_dm_id, :notes,
                  magic_items_attributes: magic_item_params)
  end
end
