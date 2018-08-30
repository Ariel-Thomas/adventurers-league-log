class CharactersController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show, :print, :print_condensed]

  before_action :load_user
  before_action :load_character, only: [:show, :export, :print, :print_condensed, :edit, :update, :destroy]

  before_action :load_overrides,    only: [:edit]
  before_action :enforce_overrides, only: [:create, :update]

  before_action :load_factions, only: [:new, :create, :edit, :update]
  before_action :load_lifestyles, only: [:new, :create, :edit, :update]

  def index
    authorize @user, :show_characters?

    params[:q] = { s: 'id asc' } unless params[:q]
    @search     = Character.where(user_id: @user.id).search(params[:q])
    @characters = @search.result(distinct: false).page params[:page]
  end

  def show
    authorize @character

    params[:q] = JSON.parse(params[:q].gsub('=>', ': ')).symbolize_keys if params[:q].class == String && params[:q].length >= 2
    params[:q] = { type_not_eq: 'DmLogEntry', s: 'date_played desc' } unless params[:q].present?
    @dm_logs_enabled = params[:q][:type_not_eq] != 'DmLogEntry'

    @search      = @character.log_entries.search(params[:q])
    @log_entries = @search.result(distinct: false).page params[:page]
    @magic_items = @character.magic_items.order(:id).purchased.not_traded

    @style = @user.character_style

    respond_to do |format|
      format.html
      format.csv { send_data CharacterCsvExporter.new(@character).export() }
    end
  end

  def print
    authorize @character, :print?

    unless @character.publicly_visible
      redirect_to(:root) && return unless @character.user == current_user
    end

    @log_entries = @character.log_entries.order(date_played: :asc).all

    @total_xp          = 0
    @total_gp          = 0
    @total_downtime    = 0
    @total_renown      = 0
    @total_magic_items = 0

    @total_acp         = @character.checkpoints_from_xp
    @total_tcp1        = 0
    @total_tcp2        = 0
    @total_tcp3        = 0
    @total_tcp4        = 0

    render 'log_entries/print_character'
  end

  def print_condensed
    authorize @character, :print?

    unless @character.publicly_visible
      redirect_to(:root) && return unless @character.user == current_user
    end

    @log_entries = @character.log_entries.order(date_played: :asc).all
    @character_style_old = @user.character_style_old?

    render 'log_entries/print_character_condensed'
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
    session[:return_to] = request.referer
  end

  def update
    authorize @character

    if @character.update_attributes(character_params)
      redirect_to (session[:return_to] || user_characters_path(@user)),
                  flash: { notice: "Successfully updated character #{@character.name}" }
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
    @use_faction_override = if @character.faction_override
                              true
                            else
                              false
                            end

    @use_lifestyle_override = if @character.lifestyle_override
                                true
                              else
                                false
                              end
  end

  def enforce_overrides
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

  def load_factions
    @factions = Faction.all
  end

  def load_lifestyles
    @lifestyles = Lifestyle.all
  end

  def character_params
    params.require(:character).permit(:name, :race, :class_and_levels, :faction_override,
                                      :faction_id, :background, :lifestyle_override, :lifestyle_id,
                                      :portrait_url, :character_sheet_url, :publicly_visible,
                                      :conversion_speed, :conversion_type)
  end
end
