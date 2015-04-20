class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionController::MimeResponds

  def redirect_to(*args)
    flash.keep
    super
  end

end
