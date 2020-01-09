require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user =       users(:michael)
		@other_user = users(:archer)
	end

  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_registration_path(@user)
    assert_response 401
  end

  test "should redirect update when not logged in" do
    patch user_registration_path(@user), params: { user: { name: @user.first_name,
                                              email: @user.email } }
    assert_response 401
  end

  # test "should redirect destroy when not logged in" do
  #   assert_no_difference 'User.count' do
  #     delete registration_path(@user)
  #   end
  # end

	# test 'should redirect show when not logged in' do
	# 	get user_path @user
	# 	assert_redirected_to new_user_session_path
	# end

	# test 'should show user page when logged in' do
	# 	sign_in @user
	# 	get user_path @other_user
	# 	assert_response :success
	# end
 
	# test 'should redirect index when not logged in' do
	# 	get users_path
	# 	assert_redirected_to new_user_session_path
	# end

	# test 'should show index of users when logged in' do
	# 	sign_in @user
	# 	get users_url
	# 	assert_response :success
	# end
end