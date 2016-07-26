class CharactersController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:show, :print, :print_condensed]

  before_action :load_user
  before_action :load_character,   only: [:show, :print, :print_condensed, :edit, :update, :destroy]

  before_action :load_overrides,    only: [:edit]
  before_action :enforce_overrides, only: [:create, :update]

  before_action :load_season_origins,   only: [:new, :create, :edit, :update]
  before_action :load_factions,   only: [:new, :create, :edit, :update]
  before_action :load_lifestyles,   only: [:new, :create, :edit, :update]

  def index
    authorize @user

    @search     = policy_scope(Character).search(params[:q])
    @characters = @search.result(distinct: false).page params[:page]
  end

  def show
    authorize @character

    params[:q] = JSON.parse(params[:q].gsub('=>', ': ')).symbolize_keys if params[:q].class == String
    params[:q] = { "type_eq"=> "CharacterLogEntry", "s"=>"date_played desc" } unless params[:q]
    @dm_logs_enabled = params[:q][:type_eq] != "CharacterLogEntry"

    @search      = @character.log_entries.search(params[:q])
    @log_entries = @search.result(distinct: false).page params[:page]
  end

  def print
    authorize @character, :print?

    unless (@character.publicly_visible)
      redirect_to :root and return unless (@character.user == current_user)
    end

    @log_entries = @character.log_entries.order(date_played: :asc).all

    @total_xp          = 0;
    @total_gp          = 0;
    @total_downtime    = 0;
    @total_renown      = 0;
    @total_magic_items = 0;
  end

  def print_condensed
    authorize @character, :print?

    unless (@character.publicly_visible)
      redirect_to :root and return unless (@character.user == current_user)
    end

    @log_entries = @character.log_entries.order(date_played: :asc).all
  end


  def new
    @character = @user.characters.new
    authorize @character
  end

  def create
    @character = @user.characters.build(character_params)
    authorize @character

    if @character.save
      redirect_to user_characters_path(@user), flash: { notice: "Successfully created character #{@character.name}" }
    else
      flash.now[:error] = "Failed to create character #{@character.name}: #{@character.errors.full_messages.join(',')}"
      render :new
    end
  end

  def edit
    authorize @character
  end

  def update
    authorize @character

    if @character.update_attributes(character_params)
      redirect_to user_characters_path(@user), flash: { notice: "Successfully updated character #{@character.name}" }
    else
      flash.now[:error] = "Failed to update character #{@character.name}: #{@character.errors.full_messages.join(',')}"
      render :edit
    end
  end

  def destroy
    authorize @character

    @character.destroy

    redirect_to user_characters_path(@user), notice: "Successfully deleted #{@character.name}"
  end

  protected
    def load_user
      @user = User.find(params[:user_id])
    end

    def load_character
      @character = @user.characters.find(params[:id])
    end

    def load_overrides
      if @character.season_origin_override
        @use_season_origin_override = true
      else
        @use_season_origin_override = false
      end

      if @character.faction_override
        @use_faction_override = true
      else
        @use_faction_override = false
      end

      if @character.lifestyle_override
        @use_lifestyle_override = true
      else
        @use_lifestyle_override = false
      end
    end

    def enforce_overrides
      if params[:use_season_origin_override]
        params[:character][:season_origin_id] = nil
      else
        params[:character][:season_origin_override] = nil
      end

      if params[:use_faction_override]
        params[:character][:faction_id] = nil
      else
        params[:character][:faction_override] = nil
      end

      if params[:use_lifestyle_override]
        params[:character][:lifestyle_id] = nil
      else
        params[:character][:lifestyle_override] = nil
      end
    end

    def load_season_origins
      @season_origins = SeasonOrigin.all
    end

    def load_factions
      @factions = Faction.all
    end

    def load_lifestyles
      @lifestyles = Lifestyle.all
    end

    def character_params
      params.require(:character).permit(:name, :season_origin_override, :season_origin_id, :race, :class_and_levels, :faction_override, :faction_id, :background, :lifestyle_override, :lifestyle_id,  :portrait_url, :publicly_visible)
    end
end
