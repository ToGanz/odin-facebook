class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    #feed
  end

  def show
    #profile
  end
end
