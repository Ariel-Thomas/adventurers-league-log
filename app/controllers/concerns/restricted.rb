module Restricted
  extend ActiveSupport::Concern

  included do
    include Pundit
    after_action :verify_authorized
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    before_action :authenticate_user!
  end

  private

  def user_not_authorized
    redirect_to (current_user ? user_characters_path(current_user) : root_path), flash: { error: 'You are not authorized to perform this action.' }
  end
end
