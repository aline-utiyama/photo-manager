require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    post users_url, params: { user: { user_id: "12345", password: "password" } }
    assert_redirected_to photos_path
    assert_equal "create", @controller.action_name
  end

  test "should get new" do
    get signup_url
    assert_response :success
    assert_equal "new", @controller.action_name
  end
end
