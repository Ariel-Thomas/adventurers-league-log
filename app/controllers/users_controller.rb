class UsersController < AuthenticationController
  def edit
    @user = User.find(params[:id])

    unless (@user == current_user)
      redirect_to :root and return
    end
  end

  def update
    @user = User.find(params[:id])

    unless (@user == current_user)
      redirect_to :root and return
    end

    if @user.update_attributes(user_params)
      redirect_to user_characters_path(current_user), notice: "Successfully updated user #{@user.email}"
    else
      flash.now[:error] = "Failed to update user #{@user.email}: #{@user.errors.full_messages.join(',')}"
      render :edit
    end
  end

  protected

    def user_params
      params.require(:user).permit(:name, :dci_num)
    end
end