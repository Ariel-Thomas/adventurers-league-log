# :nodoc:
class DmLogEntriesController < LogEntriesController
  skip_before_action :authenticate_user!, only: [:index, :show]

  add_crumb('Home', '/')
  before_filter :set_magic_item_character_id, only: [:create, :update]

  before_filter :load_user
  before_filter :load_log_entry, only: [:show, :edit, :update, :destroy]
  before_filter :load_characters, only: [:index, :new, :create, :edit, :update]
  before_filter :load_hourly_xp_lookup_table, only: [:new, :create, :edit, :update]
  before_filter :load_character,  only: [:create, :update]
  before_filter :load_locations, only: [:new, :create, :edit, :update]
  before_filter :build_log_entry, only: [:create]
  before_filter :load_magic_items, only: [:create, :update]
  before_filter :set_character, only: [:create, :update]

  before_filter(except: [:print, :print_condensed]) { add_crumb('DM Logs', user_dm_log_entries_path(@user)) }
  before_filter(only: [:new])  { add_crumb 'New Log Entry' }
  before_filter(only: [:edit]) { add_crumb 'Edit Log Entry' }
  before_filter(only: [:show]) { add_crumb 'Show Log Entry' }

  def index
    authorize @user, :publicly_visible_dm_logs?

    @hide_assigned_enabled = params[:q][:log_assignments_character_id_null]

    @search                   = @user.dm_log_entries.search(params[:q])
    @prepaginated_log_entries = @search.result(distinct: false)
    @log_entries              = @prepaginated_log_entries.page params[:page]

    set_index_stats
  end

  def show
    authorize @log_entry
    @magic_items = @log_entry.magic_items
  end

  def print
    authorize @user, :publicly_visible_dm_logs?

    @log_entries = @user.dm_log_entries.order(date_dmed: :asc)

    render 'print'
  end

  def new
    @log_entry   = @user.dm_log_entries.new
    authorize @log_entry

    @magic_items = [MagicItem.new]
    @magic_item_count = 0
  end

  def create
    authorize @log_entry
    manage_locations

    if @log_entry.save
      redirect_to [@user, DmLogEntry, q: params[:q]],
                  flash: { notice: 'Successfully created log entry '\
                                   "#{@log_entry.adventure_title}" }
    else
      flash.now[:error] = log_entry_error_message 'create'
      render :new, q: params[:q]
    end
  end

  def edit
    authorize @log_entry

    session[:return_to] = request.referer

    @magic_items = [MagicItem.new] + @log_entry.magic_items
    @magic_item_count = @log_entry.magic_items.count
  end

  def update
    authorize @log_entry
    manage_locations

    if @log_entry.update_attributes(log_entries_params)
      if session[:return_to]
        redirect_to session[:return_to],
                  flash: { notice: 'Successfully updated log entry '\
                                   "#{@log_entry.adventure_title}" }
      else
        redirect_to [@user, DmLogEntry, q: params[:q]],
                  flash: { notice: 'Successfully updated log entry '\
                                   "#{@log_entry.adventure_title}" }
      end
    else
      flash.now[:error] = log_entry_error_message 'update'
      render :edit, q: params[:q]
    end
  end

  def destroy
    authorize @log_entry
    @log_entry.destroy

    redirect_to request.referrer,
                flash: { notice: 'Successfully deleted Log Entry '\
                                 "#{@log_entry.adventure_title}" }
  end

  protected

  def set_magic_item_character_id
    params[:dm_log_entry][:magic_items_attributes].each do |attrs|
      attrs[1][:character_id] = params[:dm_log_entry][:character_id];
    end
  end

  def load_characters
    @characters = @user.characters
  end

  def load_hourly_xp_lookup_table
    @hourly_xp_lookup_table = [ 0, 50,  75, 100, 150,  225,  250,  325,  375,  475,  575,
                                  650, 725, 800, 925, 1125, 1250, 1550, 1675, 1875, 2500 ]
  end

  def load_character
    character_id_param = params[:dm_log_entry][:character_id]
    @character = @user.characters.find_by_id(character_id_param)
  end

  def build_log_entry
    @log_entry = @user.dm_log_entries.build(log_entries_params)
  end

  def set_character
    if @character
      @log_entry.characters = [@character]
    else
      @log_entry.characters = []
    end
  end

  def log_entries_params
    params.require(:dm_log_entry)
          .permit(:adventure_title, :session_num, :date_dmed,
                  :session_length_hours, :player_level,
                  :xp_gained, :gp_gained, :renown_gained,
                  :downtime_gained, :num_secret_missions,
                  :location_played, :dm_name, :dm_dci_number, :notes,
                  :date_played, :character_id,
                  magic_items_attributes: magic_item_params)
  end

  def set_index_stats
    @total_xp        = @prepaginated_log_entries.pluck(:xp_gained).compact.inject(:+) || 0
    @unused_xp       = @prepaginated_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:xp_gained).compact.inject(:+) || 02
    @total_hours     = @prepaginated_log_entries.pluck(:session_length_hours).compact.inject(:+) || 0
    @total_gp        = @prepaginated_log_entries.pluck(:gp_gained).compact.inject(:+) || 0
    @unused_gp       = @prepaginated_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:gp_gained).compact.inject(:+) || 0
    @total_downtime  = @prepaginated_log_entries.pluck(:downtime_gained).compact.inject(:+) || 0
    @unused_downtime = @prepaginated_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:downtime_gained).compact.inject(:+) || 0
    @total_renown    = @prepaginated_log_entries.pluck(:renown_gained).compact.inject(:+) || 0
    @unused_renown   = @prepaginated_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:renown_gained).compact.inject(:+) || 0
  end
end
