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
    get edit_user_registration_path
    assert_redirected_to new_user_session_path
  end

  test "should redirect update when not logged in" do
    patch user_registration_path, params: { user: { name: @user.first_name,
                                              email: @user.email } }
    assert_redirected_to new_user_session_path
  end

end