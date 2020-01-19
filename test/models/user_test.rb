require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(first_name: "Example", last_name: "User",
                     email: "user@example.com", birthday: "05.08.1990",
                     password: "123456", password_confirmation: "123456")
    @user1 = users(:michael)
    @user2 = users(:archer)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "fist name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "should friend and unfriend a user" do
    assert_not @user.friends.include?(@user1)
    @user.friends << @user1
    assert @user.friends.include?(@user1)
    @user.save
    assert @user1.friends.include?(@user)
    @user.remove_friend(@user1)
    assert_not @user.friends.include?(@user1)
    @user.save
    assert_not @user1.friends.include?(@user)
  end

  test "associated friendships should be destroyed" do
    @user.save
    @user.friendships.create!(friend_id: @user1.id)
    # -2 because of inverse friendship
    assert_difference 'Friendship.count', -2 do
      @user.destroy
    end
  end

  test "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    # Posts from friend
    lana.posts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.posts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from no friend user
    archer.posts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end

end
