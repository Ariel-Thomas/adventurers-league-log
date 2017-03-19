# :nodoc:
class PlayerDmsController < AuthenticationController
  before_action :load_user
  before_action :load_dm, only: [:edit, :update, :destroy]

  def index
    authorize @user, :manage_dms?
    @player_dms = @user.player_dms
  end

  def new
    @player_dm = @user.player_dms.new
    authorize @player_dm
  end

  def create
    @player_dm = @user.player_dms.build(player_dm_params)
    authorize @player_dm

    if @player_dm.save
      redirect_to user_player_dms_path(@user), flash: { notice: "Successfully created DM #{@player_dm.name}" }
    else
      flash.now[:error] = "Failed to create DM #{@player_dm.name}: #{@player_dm.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
    authorize @player_dm
  end

  def update
    authorize @player_dm

    if @player_dm.update_attributes(player_dm_params)
      redirect_to user_player_dms_path(@user), flash: { notice: "Successfully updated DM #{@player_dm.name}" }
    else
      flash.now[:error] = "Failed to update DM #{@player_dm.name}: #{@player_dm.errors.full_messages.join(',')}"
      render :edit
    end
  end


  def destroy
    authorize @player_dm

    @player_dm.destroy

    redirect_to user_player_dms_path(@user), notice: "Successfully deleted #{@player_dm.name}"
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_dm
    @player_dm = PlayerDm.find(params[:id])
  end

  def player_dm_params
    params.require(:player_dm).permit(:name, :dci)
  end
end