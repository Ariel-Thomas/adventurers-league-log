class CharactersController < AuthenticationController
  def index
    @search     = current_user.characters.search(params[:q])
    @characters = @search.result(distinct: false).page params[:page]
  end

  def show
    @character   = current_user.characters.find(params[:id])

    @search      = @character.log_entries.search(params[:q])
    @log_entries = @search.result(distinct: false).page params[:page]
  end

  def new
    @character = current_user.characters.new
  end

  def create
    @character = current_user.characters.build(character_params)

    if @character.save
      redirect_to user_characters_path(current_user), flash: { notice: "Successfully created character #{@character.name}" }
    else
      flash.now[:error] = "Failed to create character #{@character.name}: #{@character.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
    @character = current_user.characters.find(params[:id])
  end

  def update
    @character = current_user.characters.find(params[:id])

    if @character.update_attributes(character_params)
      redirect_to user_characters_path(current_user), flash: { notice: "Successfully updated character #{@character.name}" }
    else
      flash.now[:error] = "Failed to update character #{@character.name}: #{@character.errors.full_messages.join(',')}"
      render :new
    end
  end

  def destroy
    @character = current_user.characters.find(params[:id])
    @character.destroy

    redirect_to user_characters_path(current_user), notice: "Successfully deleted #{@character.name}"
  end

  protected

    def character_params
      params.require(:character).permit(:name, :race, :class_and_levels, :faction, :portrait_url)
    end
end
