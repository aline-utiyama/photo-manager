require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
    assert_equal "new", @controller.action_name
  end

  test "should get create" do
    user = User.new(user_id: "12345", password: "password")
    user.save
    post login_url(user_id: user.user_id, password: user.password)
    assert_redirected_to photos_path
    assert_equal "create", @controller.action_name
  end

  test "should not create" do
    user = User.new(user_id: "12345", password: "password")

    post login_url(user_id: user.user_id, password: user.password)
    assert_redirected_to login_path
    assert_equal "create", @controller.action_name
  end

  test "should get destroy" do
    get logout_url
    assert_redirected_to login_path
    assert_equal "destroy", @controller.action_name
  end
end
