require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def setup
    @user1 = users(:michael)
    @user2 = users(:archer)
    @friendship = Friendship.new(user_id: @user1.id,
                                     friend_id: @user2.id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "should require a user_id" do
    @friendship.user_id = nil
    assert_not @friendship.valid?
  end

  test "should require a friend_id" do
    @friendship.friend_id = nil
    assert_not @friendship.valid?
  end

  test "inverse relationship should be created" do
    @friendship.save
    assert_equal @user1.friendships.find_by(friend_id: @user2.id).user_id, 
                 @user2.friendships.find_by(friend_id: @user1.id).friend_id
    assert_equal @user2.friendships.find_by(friend_id: @user1.id).user_id, 
                 @user1.friendships.find_by(friend_id: @user2.id).friend_id
  end

  test "inverse relationship should be destroyed" do
    @friendship.save
    assert_difference '@user2.friendships.count', -1 do
      @friendship.destroy
    end
  end

end
