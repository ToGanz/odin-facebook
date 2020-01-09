require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @friend_request = FriendRequest.new(user_id: users(:michael).id,
                                     friend_id: users(:archer).id)
  end

  test "should be valid" do
    assert @friend_request.valid?
  end

  test "should require a user_id" do
    @friend_request.user_id = nil
    assert_not @friend_request.valid?
  end

  test "should require a friend_id" do
    @friend_request.friend_id = nil
    assert_not @friend_request.valid?
  end

  test "user_id should be different from friend_id" do
    @friend_request.friend_id =  users(:michael).id
    assert_not @friend_request.valid?
  end

  test "friend request shouldn't already be pending" do
    duplicate_request = @friend_request.dup
    @friend_request.save
    assert_not duplicate_request.valid?
  end

  test "user shouldn't already be friend" do
    duplicate_request = @friend_request.dup
    @friend_request.save 
    @friend_request.accept
    assert_not duplicate_request.valid?
  end

end
