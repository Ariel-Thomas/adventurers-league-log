class UsersController < AuthenticationController
  def edit
    @user = User.find(params[:id])
    authorize @user

    redirect_to(:root) && return unless @user == current_user
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    redirect_to(:root) && return unless @user == current_user

    if @user.update_attributes(user_params)
      redirect_to user_characters_path(current_user), notice: "Successfully updated user #{@user.email}"
    else
      flash.now[:error] = "Failed to update user #{@user.email}: #{@user.errors.full_messages.join(',')}"
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :dci_num, :publicly_visible, :receive_emails)
  end
end
