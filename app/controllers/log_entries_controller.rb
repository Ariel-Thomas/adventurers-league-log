# :nodoc:
class LogEntriesController < AuthenticationController
  before_action :convert_query_string_to_hash, only: [:index]
  before_action :load_log_entry_type

  def convert_query_string_to_hash
    params.delete(:q) if params[:q].blank?

    if params[:q]
      if params[:q].class == String
        params[:q] = JSON.parse(params[:q]
                         .gsub('=>', ': '))
                         .symbolize_keys
      end

      params[:q] = params[:q].delete_if { |k, v| v.empty? }
    else
      params[:q] = { s: 'date_dmed desc' }
    end
  end

  def load_log_entry_type
    @log_entry_type = controller_name.classify.singularize.underscore.to_sym
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_log_entry
    @log_entry = LogEntry.find(params[:id])
  end

  def load_magic_items
    @magic_items = @log_entry.magic_items
    @magic_item_count = @log_entry.magic_items.count
  end

  def load_locations
    @locations = @user.locations.order(:name).all
  end

  def manage_locations
    return if params[@log_entry_type][:location_played].empty?

    @user.locations.find_or_create_by(name: params[@log_entry_type][:location_played])
  end

  def adventure_form_inputs_include_adventure?
    @adventure_form_inputs.find_by(name: @log_entry.adventure_title)
  end

  def log_entry_error_message(action)
    "Failed to #{action} log entry "\
    "#{@log_entry.adventure_title}: "\
    "#{@log_entry.errors.full_messages.join(',')}"
  end

  def magic_item_params
    [:id, :name, :rarity, :tier, :location_found, :table, :table_result,
      :character_id, :purchased, :log_entry, :log_entry_id, :purchase_log_entry, :purchase_log_entry_id, :not_included_in_count, :notes, :_destroy]
  end
end
