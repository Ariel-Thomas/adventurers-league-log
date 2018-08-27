class CharacterCampaignsController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  add_crumb('Home', '/')
  before_action :load_user
  before_action :load_character
  before_action :load_campaign,  except: [:new, :create]

  before_action { add_crumb('Campaigns', user_campaigns_path(@user)) }
  before_action(only: [:new])  { add_crumb 'New Campaign' }
  before_action(only: [:edit]) { add_crumb 'Edit Campaign' }
  before_action(only: [:show]) { add_crumb 'Show Campaign' }

  def create
    @campaign  = Campaign.find_by(token: params[:campaign_participation][:token])
    @campaign_participation = CampaignParticipation.new(character: @character, campaign: @campaign)

    authorize @campaign_participation

    if @campaign_participation.save
      redirect_to [@user, @campaign], flash: { notice: "Successfully joined campaign #{@campaign.name}" }
    else
      flash.now[:error] = "Failed to join campaign #{@campaign.name}: #{@campaign_participation.errors.full_messages.join(',')}"
      redirect_to user_campaigns_path(@user)
    end
  end

  def destroy
    @campaign_participation = @character.campaign_participations.find_by(campaign: @campaign)
    authorize @campaign_participation

    @campaign_participation.destroy

    redirect_to user_campaigns_path(@user), notice: "Successfully left #{@campaign.name}"
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_character
    @character = @user.characters.find(params[:character_id])
  end

  def load_campaign
    @campaign = @user.character_campaigns.find(params[:id])
  end
end
