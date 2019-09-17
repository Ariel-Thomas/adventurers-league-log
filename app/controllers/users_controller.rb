class UsersController < AuthenticationController
  def show
    @user = User.find(params[:id])
    redirect_to(user_characters_path(@user)) && return
  end

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
    params.require(:user).permit(:name, :dci_num,
                                 :publicly_visible_characters, :publicly_visible_dm_logs,
                                 :receive_emails,
                                 :autocalc_default, :round_checkpoints_override,
                                 :automagic_gold_toggle_override, :automagic_downtime_toggle_override,
                                 :character_style, :character_log_entry_style, :magic_item_style, :dm_style, :dm_log_entry_style)
  end
end
