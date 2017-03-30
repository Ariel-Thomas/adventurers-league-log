class MagicItemsController < AuthenticationController
  skip_before_action :authenticate_user!, only: [:index, :show, :print, :print_condensed]

  before_action :load_user
  before_action :load_character

  before_filter { add_crumb('Charactes', user_characters_path(@user)) }
  before_filter(only: [:index])  { add_crumb(@character.name, user_character_path(@user, @character)) }
  before_filter(only: [:index]) { add_crumb 'Magic Items' }

  def index
    authorize @user, :show_characters?

    @search      = @character.magic_items.where(trade_log_entry_id: nil).search(params[:q])
    @magic_items = @search.result(distinct: false).page params[:page]
  end

  def destroy
    @magic_item = MagicItem.find(params[:id])
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
end
