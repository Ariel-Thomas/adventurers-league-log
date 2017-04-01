class CampaignLogEntriesController < LogEntriesController
  skip_before_action :authenticate_user!, only: [:show]

  add_crumb('Home', '/')
  before_filter :load_user
  before_filter :load_character, only: [:show]
  before_filter :load_campaign,
                only: [:show, :new, :create, :edit, :update, :destroy]
  before_filter :load_log_entry,
                only: [:show, :edit, :update, :destroy]

  before_filter(only: [:show]) do
    add_crumb @character.name,
              user_character_path(@character.user, @character) if @character
  end
  before_filter(only: [:show]) do
    add_crumb @campaign.name,
              user_campaign_path(@campaign.user, @campaign) if @campaign
  end

  before_filter(only: [:new, :create, :edit, :update]) do
    add_crumb @campaign.name,
              user_campaign_path(@campaign.user, @campaign)
  end

  before_filter(only: [:show]) { add_crumb @log_entry.adventure_title }

  before_filter(only: [:new,  :create]) { add_crumb 'New Log Entry' }
  before_filter(only: [:edit, :update]) { add_crumb 'Edit Log Entry' }

  def show
    authorize @log_entry
    @magic_items = @log_entry.magic_items
    @magic_items = @magic_items.where(character: @character) if @character
  end

  def new
    @log_entry   = @campaign.campaign_log_entries.new
    authorize @log_entry

    @log_entry.characters = @campaign.characters
    @magic_items = [MagicItem.new]
    @magic_item_count = 0
  end

  def create
    @log_entry = @campaign.campaign_log_entries.build(log_entries_params)
    @log_entry.dm_name       = @user.name
    @log_entry.dm_dci_number = @user.dci_num
    authorize @log_entry

    if @log_entry.save
      redirect_to [@user, @campaign],
                  flash: { notice: 'Successfully created log entry'\
                                   "#{@log_entry.adventure_title}" }
    else
      @magic_items      = @log_entry.magic_items
      @magic_item_count = @log_entry.magic_items.count

      error_message = 'Failed to create log_entry '\
                      "#{@log_entry.adventure_title}: "\
                      "#{@log_entry.errors.full_messages.join(',')}"
      flash.now[:error] = error_message
      render :new
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
      redirect_to [@user, @campaign],
                  flash: { notice: 'Successfully updated log entry'\
                                   "#{@log_entry.adventure_title}" }
    else
      @magic_items      = @log_entry.magic_items
      @magic_item_count = @log_entry.magic_items.count

      flash.now[:error] = 'Failed to update log_entry'\
                          "#{@log_entry.adventure_title}:"\
                          "#{@log_entry.errors.full_messages.join(',')}"
      render :edit
    end
  end

  def destroy
    authorize @log_entry
    @log_entry.destroy

    redirect_to [@user, @campaign],
                flash: { notice: 'Successfully deleted Campaign Log Entry'\
                                 "#{@log_entry.id}" }
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_character
    @character = Character.find(params[:character_id]) if params[:character_id]
  end

  def load_campaign
    @campaign  = Campaign.find(params[:campaign_id]) if params[:campaign_id]
  end

  def log_entry
    if @campaign
      @campaign.campaign_log_entries.find(params[:id])
    else
      CampaignLogEntry.find(params[:id])
    end
  end

  def load_log_entry
    @log_entry ||= log_entry
  end

  def log_entries_params
    params.require(:campaign_log_entry)
          .permit(:adventure_title, :session_num, :date_played,
                  :xp_gained, :gp_gained, :renown_gained, :downtime_gained,
                  :num_secret_missions, :location_played, :notes,
                  character_ids: [],
                  magic_items_attributes: magic_item_params)
  end

end
