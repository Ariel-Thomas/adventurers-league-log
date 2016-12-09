# :nodoc:
class AdventuresController < ApplicationController
  autocomplete :form_input, :name, :full => true
  skip_after_action :verify_authorized
end