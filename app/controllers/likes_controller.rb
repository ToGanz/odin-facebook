class LikesController < ApplicationController

  def save_like
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
  
    respond_to do |format|
      format.json {
        if @like.save
          { succes: true }
        else
          { succes: false }
        end
      }
    end
  end

end
