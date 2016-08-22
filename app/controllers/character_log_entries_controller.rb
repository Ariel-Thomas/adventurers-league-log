class CharacterLogEntriesController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:show]

  add_crumb('Home', '/')
  before_filter :load_user
  before_filter :load_character
  before_filter :load_log_entry, only: [:show, :edit, :update, :destroy]
  before_filter :load_adventure_form_inputs, only: [:new, :create, :edit, :update]
  before_filter :load_player_dms, only: [:new, :create, :edit, :update]
  before_filter :load_overrides, only: [:edit, :update]

  before_filter { add_crumb @character.name, user_character_path(@character.user, @character) }

  before_filter(only: [:new]) { add_crumb "New Log Entry" }
  before_filter(only: [:show, :edit]) { add_crumb @log_entry.adventure_title, user_character_character_log_entry_path(@character.user, @character, @log_entry) }

  def show
    authorize @log_entry
    @magic_items = @log_entry.magic_items
  end

  def new
    @log_entry   = @character.character_log_entries.new
    authorize @log_entry
    @magic_items = [MagicItem.new]
    @magic_item_count = 0;
  end

  def create
    @log_entry   = @character.character_log_entries.build(log_entries_params)
    authorize @log_entry
    manage_player_dms

    if @log_entry.save
      redirect_to user_character_path(current_user, @character, q: params[:q]), flash: { notice: "Successfully created character #{@log_entry.adventure_title}" }
    else
      @magic_items = @log_entry.magic_items
      @magic_item_count = @log_entry.magic_items.count;

      flash.now[:error] = "Failed to create log_entry #{@log_entry.adventure_title}: #{@log_entry.errors.full_messages.join(',')}"
      render :new, q: params[:q]
    end
  end

  def edit
    authorize @log_entry
    @magic_items = [MagicItem.new] + @log_entry.magic_items
    @magic_item_count = @log_entry.magic_items.count;
  end

  def update
    authorize @log_entry
    manage_player_dms

    if @log_entry.update_attributes(log_entries_params)
      redirect_to user_character_path(current_user, @character, q: params[:q]), flash: { notice: "Successfully updated character #{@log_entry.adventure_title}" }
    else
      @magic_items = [MagicItem.new] + @log_entry.magic_items
      @magic_item_count = @log_entry.magic_items.count;

      flash.now[:error] = "Failed to update log_entry #{@log_entry.adventure_title}: #{@log_entry.errors.full_messages.join(',')}"
      render :edit, q: params[:q]
    end
  end


  def destroy
    authorize @log_entry
    @log_entry.destroy

    redirect_to user_character_path(current_user, @character, q: params[:q]), flash: { notice: "Successfully deleted #{@log_entry.adventure_title}" }
  end

  protected
    def load_user
      @user   = User.find(params[:user_id])
    end

    def load_character
      @character   = Character.find(params[:character_id])
    end

    def load_log_entry
      @log_entry   = LogEntry.find(params[:id])
    end

    def load_adventure_form_inputs
      @adventure_form_inputs  = AdventureFormInput.order(:position_num).all
    end

    def load_player_dms
      @player_dms  = @user.player_dms.all
    end

    def load_overrides
      @use_adventure_override = !@adventure_form_inputs.find_by(name: @log_entry.adventure_title)
    end

    def manage_player_dms
      if params[:character_log_entry][:player_dm_id] && params[:character_log_entry][:player_dm_id] != ""
        @player_dm = @user.player_dms.find(params[:character_log_entry][:player_dm_id])

        params[:character_log_entry][:dm_name]       = @player_dm.name
        params[:character_log_entry][:dm_dci_number] = @player_dm.dci
      elsif params[:character_log_entry][:dm_dci_number]
        @player_dm = @user.player_dms.find_by(dci: params[:character_log_entry][:dm_dci_number])

        unless @player_dm
          @player_dm = @user.player_dms.create!(
            name: params[:character_log_entry][:dm_name],
            dci: params[:character_log_entry][:dm_dci_number])
          params[:character_log_entry][:player_dm_id]
        end

        params[:character_log_entry][:player_dm_id] = @player_dm.id
      end
    end

    def log_entries_params
      params.require(:character_log_entry).permit(:adventure_title, :session_num, :date_played, :xp_gained, :gp_gained, :renown_gained, :downtime_gained, :num_secret_missions, :location_played, :dm_name, :dm_dci_number, :player_dm_id, :notes, magic_items_attributes: [:id, :name, :rarity, :notes, :_destroy])
    end
end
