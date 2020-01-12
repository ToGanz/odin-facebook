class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    #feed
  end

  def show
    #profile
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    
  end
end
