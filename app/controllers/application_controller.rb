class ApplicationController < ActionController::Base
  include ActionController::MimeResponds

  def redirect_to(*args)
    flash.keep
    super
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
