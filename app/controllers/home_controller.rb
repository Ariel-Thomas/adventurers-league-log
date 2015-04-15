class HomeController < ApplicationController
  def index
    if (current_user)
      redirect_to user_characters_path(current_user) and return
    else
      @show_jumbotron = true
    end
  end
end
