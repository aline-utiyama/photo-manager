require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should save the user with id and password" do
    user = User.new(user_id: "12345", password: "password")
    assert user.save
  end

  test "should not save the user without id" do
    user = User.new(password: "password")
    assert_not user.save
  end

  test "should not save the user without password" do
    user = User.new(user_id: "1234")
    assert_not user.save
  end
end
