class LikesController < ApplicationController

  def create
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
  
    if @like.save
    end
    redirect_to root_url
 
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to request.referrer || root_url
  end

end
