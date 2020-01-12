class ApplicationController < ActionController::Base

  helper_method :incoming_friend_requests

  def incoming_friend_requests
    FriendRequest.where(friend: current_user)
  end

end
