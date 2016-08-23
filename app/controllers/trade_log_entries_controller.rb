class TradeLogEntriesController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:show]

  add_crumb('Home', '/')
  before_filter :load_user
  before_filter :load_character
  before_filter :load_log_entry, only: [:show, :edit, :update, :destroy]

  before_filter { add_crumb @character.name, user_character_path(@character.user, @character) }

  before_filter(only: [:new]) { add_crumb "New Trade Log Entry" }
  before_filter(only: [:show, :edit]) { add_crumb "Trade Log Entry" }

  def show
    authorize @log_entry
    @traded_magic_item = @log_entry.traded_magic_item
    @received_magic_items = @log_entry.magic_items.last
  end

  def new
    @log_entry      = @character.trade_log_entries.new
    authorize @log_entry
    @magic_items    = @character.magic_items
    @new_magic_item = @character.magic_items.new
  end

  def create
    @new_magic_item = MagicItem.find_by_id(params[:trade_log_entry][:traded_magic_item])
    params[:trade_log_entry].delete(:traded_magic_item)

    @log_entry   = @character.trade_log_entries.build(log_entries_params)
    @log_entry.traded_magic_item = @new_magic_item

    authorize @log_entry
    @magic_items = @character.magic_items

    if @log_entry.save
      redirect_to user_character_path(current_user, @character, q: params[:q]), flash: { notice: "Successfully created trade log entry" }
    else
      flash.now[:error] = "Failed to create trade log entry: #{@log_entry.errors.full_messages.join(',')}"
      render :new, q: params[:q]
    end
  end

  # def edit
  #   authorize @log_entry
  #   @magic_items = [MagicItem.new] + @log_entry.magic_items
  #   @magic_item_count = @log_entry.magic_items.count;
  # end

  # def update
  #   authorize @log_entry
  #   manage_player_dms

  #   if @log_entry.update_attributes(log_entries_params)
  #     redirect_to user_character_path(current_user, @character, q: params[:q]), flash: { notice: "Successfully updated character #{@log_entry.adventure_title}" }
  #   else
  #     @magic_items = [MagicItem.new] + @log_entry.magic_items
  #     @magic_item_count = @log_entry.magic_items.count;

  #     flash.now[:error] = "Failed to update log_entry #{@log_entry.adventure_title}: #{@log_entry.errors.full_messages.join(',')}"
  #     render :edit, q: params[:q]
  #   end
  # end


  # def destroy
  #   authorize @log_entry
  #   @log_entry.destroy

  #   redirect_to user_character_path(current_user, @character, q: params[:q]), flash: { notice: "Successfully deleted #{@log_entry.adventure_title}" }
  # end

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

    def log_entries_params
      params.require(:trade_log_entry).permit(:date_played, :downtime_gained, :traded_magic_item, :notes, magic_items_attributes: [:id, :name, :rarity, :notes, :_destroy])
    end
end
