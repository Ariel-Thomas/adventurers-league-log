class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionController::MimeResponds
  before_action :configure_permitted_parameters, if: :devise_controller?

  def redirect_to(*args)
    flash.keep
    super
  end




  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :receive_emails])
  end
end
