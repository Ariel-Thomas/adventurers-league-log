class AuthenticationController < ApplicationController
  before_action :authenticate_user!
end
