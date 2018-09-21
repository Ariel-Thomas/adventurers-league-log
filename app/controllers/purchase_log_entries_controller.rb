# :nodoc:
class PurchaseLogEntriesController < LogEntriesController
  skip_before_action :authenticate_user!, only: [:show]

  add_crumb('Home', '/')
  before_action :load_user
  before_action :load_character
  before_action :load_log_entry, only: [:show, :edit, :update, :destroy]
  before_action :load_current_magic_items,
                only: [:new, :create, :edit, :update]
  before_action :load_treasure_points, only: [:new, :create, :edit, :update]
  before_action :build_new_magic_item,
                only: [:new, :create, :edit, :update]
  before_action :clean_up_params, only: [:create, :update]

  before_action do
    add_crumb @character.name, user_character_path(@character.user, @character)
  end

  before_action(only: [:new]) { add_crumb 'New Purchase Log Entry' }
  before_action(only: [:show, :edit]) { add_crumb 'Purchase Log Entry' }

  def show
    authorize @log_entry
  end

  def new
    @log_entry = @character.purchase_log_entries.new
    @log_entry.characters = [@character]
    authorize @log_entry
  end

  def create
    @log_entry = @character.purchase_log_entries.build(log_entries_params)
    @log_entry.characters = [@character]
    authorize @log_entry

    @log_entry.purchased_magic_item = @new_magic_item

    if @log_entry.save
      @log_entry.magic_items = [@log_entry.purchased_magic_item] if @log_entry.purchased_magic_item && !@log_entry.purchased_magic_item.log_entry
      redirect_to user_character_path(current_user, @character, q: params.permit(:q).fetch(:q, nil)),
                  flash: { notice: 'Successfully created purchase log entry' }
    else
      flash.now[:error] = log_entry_error_message 'create'
      render :new, q: params.permit(:q).fetch(:q, nil)
    end
  end

  def edit
    authorize @log_entry
  end

  def update
    authorize @log_entry

    if @log_entry.purchased_magic_item
      if @log_entry.purchased_magic_item.log_entry.id == @log_entry.id &&
          @log_entry.purchased_magic_item.id != @new_magic_item.id
        @log_entry.purchased_magic_item.destroy
      end
    end

    if @log_entry.update_attributes(log_entries_params)
      @log_entry.purchased_magic_item = @new_magic_item
      @log_entry.magic_items = [@log_entry.purchased_magic_item] if @log_entry.purchased_magic_item && !@log_entry.purchased_magic_item.log_entry
      redirect_to user_character_path(current_user, @character, q: params.permit(:q).fetch(:q, nil)),
                  flash: { notice: 'Successfully updated purchase log entry' }
    else
      flash.now[:error] = log_entry_error_message 'update'
      render :edit, q: params.permit(:q).fetch(:q, nil)
    end
  end

  def destroy
    authorize @log_entry
    @log_entry.destroy

    redirect_to user_character_path(current_user, @character, q: params.permit(:q).fetch(:q, nil)),
                flash: { notice: 'Successfully deleted purchase log entry' }
  end

  protected

  def load_character
    @character   = Character.find(params[:character_id])
  end

  def load_log_entry
    @log_entry   = LogEntry.find(params[:id])
  end

  def load_current_magic_items
    selected_magic_item = @log_entry.purchased_magic_item if @log_entry && @log_entry.purchased_magic_item
    @magic_items = @character.magic_items.unlocked
    @magic_items_for_select = @magic_items.map {|p| [ "#{p.name} (#{p.rarity}, Tier #{p.tier})", p.id ] }
    @magic_items_for_select << ["#{selected_magic_item.name} (#{selected_magic_item.rarity}, Tier #{selected_magic_item.tier})", selected_magic_item.id] if selected_magic_item
  end

  def load_treasure_points
    @available_treasure_points =
      [1,2,3,4].map{|tier|
        @character.log_entries.earned_treasure_checkpoints(tier: tier) -
          @character.log_entries.spent_treasure_checkpoints(tier: tier)
      }
  end

  def build_new_magic_item
    magic_item = MagicItem.find_by(id: new_magic_item_params)
    if magic_item.present?
      @new_magic_item = magic_item
    elsif @log_entry && @log_entry.magic_items.last
      @new_magic_item = @log_entry.magic_items.last
    elsif magic_item_attributes_params
      @new_magic_item = MagicItem.new(magic_item_attributes_params.permit(magic_item_params))
      clean_up_magic_item_params
    else
      @new_magic_item = MagicItem.new(purchase_log_entry_id: 0)
    end
  end

  def new_magic_item_params
    params[:purchase_log_entry][:purchased_magic_item] if params[:purchase_log_entry]
  end

  def magic_item_attributes_params
    params[:purchase_log_entry][:purchased_magic_item_attributes] if params[:purchase_log_entry]
  end

  def clean_up_params
    params[:purchase_log_entry].delete(:purchased_magic_item)
  end

  def clean_up_magic_item_params
    params[:purchase_log_entry].delete(:purchased_magic_item_attributes)
  end

  def log_entries_params
    params.require(:purchase_log_entry)
          .permit(:date_played, :downtime_gained, :gp_gained,
                  :tier1_treasure_checkpoints, :tier2_treasure_checkpoints,
                  :tier3_treasure_checkpoints, :tier4_treasure_checkpoints,
                  :notes, :purchased_magic_item, purchased_magic_item_attributes: magic_item_params)
  end
end
