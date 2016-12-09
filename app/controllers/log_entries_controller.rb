# :nodoc:
class LogEntriesController < AuthenticationController
  before_filter :convert_query_string_to_hash, only: [:index]

  def convert_query_string_to_hash
    if params[:q]
      if params[:q].class == String
        params[:q] = JSON.parse(params[:q]
                         .gsub('=>', ': '))
                         .symbolize_keys
      end
    else
      params[:q] = { s: 'date_dmed desc' }
    end
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

  def adventure_form_inputs_include_adventure?
    @adventure_form_inputs.find_by(name: @log_entry.adventure_title)
  end

  def log_entry_error_message(action)
    "Failed to #{action} log entry "\
    "#{@log_entry.adventure_title}: "\
    "#{@log_entry.errors.full_messages.join(',')}"
  end
end
