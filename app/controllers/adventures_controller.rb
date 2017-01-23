# :nodoc:
class AdventuresController < ApplicationController
  autocomplete :adventure, :name, :full => true
  skip_after_action :verify_authorized

  def index
    @adventures = Adventure.all
  end
end