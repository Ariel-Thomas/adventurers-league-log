class DmLogEntriesController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  add_crumb('Home', '/')
  before_filter :load_user
  before_filter :load_characters, only: [:new, :create, :edit, :update]
  before_filter :load_character,  only: [:create, :update]
  before_filter :load_log_entry,  only: [:show, :edit, :update, :destroy]
  before_filter :load_adventure_form_inputs, only: [:new, :create, :edit, :update]
  before_filter :load_overrides, only: [:edit, :update]

  before_filter { add_crumb('DM Logs', user_dm_log_entries_path(@user)) }
  before_filter(only: [:new])  { add_crumb 'New Log Entry' }
  before_filter(only: [:edit]) { add_crumb 'Edit Log Entry' }
  before_filter(only: [:show]) { add_crumb 'Show Log Entry' }

  def index
    authorize @user, :publicly_visible_user?

    params[:q] = JSON.parse(params[:q].gsub('=>', ': ')).symbolize_keys if params[:q].class == String
    params[:q] = { s: 'date_dmed desc' } unless params[:q]
    @hide_assigned_enabled = params[:q][:log_assignments_character_id_null]

    @search      = @user.dm_log_entries.search(params[:q])
    @log_entries = @search.result(distinct: false).page params[:page]
  end

  def show
    authorize @log_entry
    @magic_items = @log_entry.magic_items
  end

  def new
    @log_entry   = @user.dm_log_entries.new
    authorize @log_entry

    @magic_items = [MagicItem.new]
    @magic_item_count = 0
  end

  def create
    @log_entry = @user.dm_log_entries.build(log_entries_params)
    @log_entry.characters = [@character] if @character
    authorize @log_entry

    if @log_entry.save
      redirect_to [@user, DmLogEntry, q: params[:q]], flash: { notice: "Successfully created log entry #{@log_entry.id}" }
    else
      @magic_items = @log_entry.magic_items
      @magic_item_count = @log_entry.magic_items.count

      flash.now[:error] = "Failed to create log_entry #{@log_entry.id}: #{@log_entry.errors.full_messages.join(',')}"
      render :new, q: params[:q]
    end
  end

  def edit
    authorize @log_entry

    @magic_items = [MagicItem.new] + @log_entry.magic_items
    @magic_item_count = @log_entry.magic_items.count
  end

  def update
    @log_entry.characters = [@character] if @character
    authorize @log_entry

    if @log_entry.update_attributes(log_entries_params)
      redirect_to [@user, DmLogEntry, q: params[:q]], flash: { notice: "Successfully updated log entry #{@log_entry.id}" }
    else
      @magic_items = [MagicItem.new] + @log_entry.magic_items
      @magic_item_count = @log_entry.magic_items.count

      flash.now[:error] = "Failed to update log_entry #{@log_entry.id}: #{@log_entry.errors.full_messages.join(',')}"
      render :edit, q: params[:q]
    end
  end

  def destroy
    authorize @log_entry
    @log_entry.destroy

    redirect_to [@user, DmLogEntry, q: params[:q]], flash: { notice: "Successfully deleted DM Log Entry #{@log_entry.id}" }
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_characters
    @characters  = @user.characters
  end

  def load_character
    @character = @user.characters.find_by_id(params[:dm_log_entry][:character_id])
  end

  def load_log_entry
    @log_entry   = DmLogEntry.find(params[:id])
  end

  def load_adventure_form_inputs
    @adventure_form_inputs  = AdventureFormInput.order(:position_num).all
  end

  def load_overrides
    @use_adventure_override = !@adventure_form_inputs.find_by(name: @log_entry.adventure_title)
  end

  def log_entries_params
    params.require(:dm_log_entry).permit(:adventure_title, :session_num, :date_dmed, :xp_gained, :gp_gained, :renown_gained, :downtime_gained, :num_secret_missions, :location_played, :dm_name, :dm_dci_number, :notes, :date_played, :character_id, magic_items_attributes: [:id, :name, :rarity, :notes, :_destroy])
  end
end
