# :nodoc:
class AdventuresController < ApplicationController
  autocomplete :adventure, :name, :full => true
  skip_after_action :verify_authorized, raise: false

  def index
    @adventures = Adventure.all
  end
end
