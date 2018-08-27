class CampaignsController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  add_crumb('Home', '/')
  before_action :load_user
  before_action :load_campaign, only: [:show, :edit, :update, :destroy]

  before_action { add_crumb('Campaigns', user_campaigns_path(@user)) }
  before_action(only: [:new])  { add_crumb 'New Campaign' }
  before_action(only: [:edit]) { add_crumb 'Edit Campaign' }
  before_action(only: [:show]) { add_crumb 'Show Campaign' }

  def index
    authorize @user

    @campaigns               = policy_scope(Campaign).all
    @campaign_participations = @user.campaign_participations
  end

  def show
    authorize @campaign

    @current_user_is_dm   = current_user && @campaign.users.exists?(current_user.id)
    @dms                  = @campaign.users
    @characters           = @campaign.characters

    params[:q] = { s: 'date_played desc' } unless params[:q]
    @search      = @campaign.campaign_log_entries.search(params[:q])
    @log_entries = @search.result(distinct: false).page params[:page]
  end

  def new
    @campaign = @user.campaigns.new
    @campaign.users = [@user]
    @campaign.users_can_join = true

    authorize @campaign
  end

  def create
    @campaign = @user.campaigns.build(campaigns_params)
    @campaign.users = [@user]
    authorize @campaign

    if @campaign.save
      redirect_to [@user, @campaign], flash: { notice: "Successfully created campaign #{@campaign.name}" }
    else
      flash.now[:error] = "Failed to create campaign #{@campaign.name}: #{@campaign.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
    authorize @campaign
  end

  def update
    authorize @campaign

    if @campaign.update_attributes(campaigns_params)
      @campaign.reset_tokens!
      redirect_to [@user, @campaign], flash: { notice: "Successfully created campaign #{@campaign.name}" }
    else
      flash.now[:error] = "Failed to create campaign #{@campaign.name}: #{@campaign.errors.full_messages.join(',')}"
      render :new
    end
  end

  def join_as_character
    @join_token = params[:token] ? params[:token] : nil

    authorize @user
    @characters = @user.characters
  end

  def join_as_dm
    @join_token = params[:token] ? params[:token] : nil

    authorize @user
  end

  def destroy
    authorize @campaign

    @campaign.destroy

    redirect_to user_campaigns_path(@user), notice: "Successfully deleted #{@campaign.name}"
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaigns_params
    params.require(:campaign).permit(:name, :users_can_join, :dms_can_join, :publicly_visible)
  end
end
