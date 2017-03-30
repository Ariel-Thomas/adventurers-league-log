class DmCampaignAssignmentsController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  add_crumb('Home', '/')
  before_filter :load_user
  before_filter :load_campaign,  except: [:new, :create]

  before_filter { add_crumb('Campaigns', user_campaigns_path(@user)) }
  before_filter(only: [:new])  { add_crumb 'New Campaign' }
  before_filter(only: [:edit]) { add_crumb 'Edit Campaign' }
  before_filter(only: [:show]) { add_crumb 'Show Campaign' }

  def create
    @campaign  = Campaign.find_by(dm_token: params[:dm_campaign_assignment][:token])
    @dm_campaign_assignment = DmCampaignAssignment.new(user: @user, campaign: @campaign)

    authorize @dm_campaign_assignment
    if @dm_campaign_assignment.save
      redirect_to [@user, @campaign], flash: { notice: "Successfully joined campaign #{@campaign.name} as a DM" }
    else
      flash.now[:error] = "Failed to join campaign #{@campaign.name}: #{@dm_campaign_assignment.errors.full_messages.join(',')}"
      redirect_to user_campaigns_path(@user)
    end
  end

  def destroy
    @dm_campaign_assignment = @user.dm_campaign_assignment.find_by(campaign: @campaign)
    authorize @dm_campaign_assignment

    @dm_campaign_assignment.destroy

    redirect_to user_campaigns_path(@user), notice: "Successfully left #{@campaign.name}"
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_campaign
    @campaign = @user.character_campaigns.find(params[:id])
  end
end