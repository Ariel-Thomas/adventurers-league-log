class MagicItemsController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show, :print, :print_condensed]

  before_action :load_user
  before_action :load_character
  before_action :load_magic_item, only: [:show, :destroy]

  before_action { add_crumb('Charactes', user_characters_path(@user)) }
  before_action(only: [:index, :show]) { add_crumb(@character.name, user_character_path(@user, @character)) }
  before_action(only: [:index, :show]) { add_crumb 'Magic Items', user_character_magic_items_path(@user, @character) }
  before_action(only: [:show])         { add_crumb(@magic_item.name) }

  def index
    authorize @user, :show_characters?

    magic_items = @character.magic_items
    @purchased_search      = magic_items.purchased.not_traded.search(params[:q])
    @purchased_magic_items = @purchased_search.result(distinct: false).page params[:page]

    @unlocked_search      = magic_items.unlocked.not_traded.search(params[:q])
    @unlocked_magic_items = @unlocked_search.result(distinct: false).page params[:page]
  end

  def show
    authorize @user, :show_characters?
  end

  def destroy
    @log_entry = @character.trade_log_entries.build()
    @log_entry.traded_magic_item = @magic_item
    @log_entry.characters = [@character]

    authorize @log_entry

    if @log_entry.save
      redirect_to user_character_magic_items_path(current_user, @character, q: params[:q]),
                  flash: { notice: 'Successfully eliminated magic item' }
    else
      flash.now[:error] = log_entry_error_message 'create'
      render :new, q: params[:q]
    end
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_character
    @character = @user.characters.find(params[:character_id])
  end

  def load_magic_item
     @magic_item = MagicItem.find(params[:id])
  end
end
