# :nodoc:
class LocationsController < AuthenticationController
  before_action :load_user
  before_action :load_location, only: [:edit, :update, :destroy]

  def index
    authorize @user, :manage_locations?
    @locations = @user.locations
  end

  def new
    @location = @user.locations.new
    authorize @location
  end

  def create
    @location = @user.locations.build(location_params)
    authorize @location

    if @location.save
      redirect_to user_locations_path(@user), flash: { notice: "Successfully created Location #{@location.name}" }
    else
      flash.now[:error] = "Failed to create Location #{@location.name}: #{@location.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
    authorize @location
  end

  def update
    authorize @location

    if @location.update_attributes(location_params)
      redirect_to user_locations_path(@user), flash: { notice: "Successfully updated Location #{@location.name}" }
    else
      flash.now[:error] = "Failed to update Location #{@location.name}: #{@location.errors.full_messages.join(',')}"
      render :edit
    end
  end


  def destroy
    authorize @location

    @location.destroy

    redirect_to user_locations_path(@user), notice: "Successfully deleted #{@location.name}"
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name)
  end
end
