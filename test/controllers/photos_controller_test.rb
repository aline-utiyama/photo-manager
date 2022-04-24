require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest

  test "should not get new if not signed in" do
    get new_photo_url
    assert_redirected_to login_path
    assert_equal "new", @controller.action_name
  end
  
  test "should get new if signed in" do
    user = User.new(user_id: "12345", password: "password")
    user.save
    post login_url(user_id: user.user_id, password: user.password)
    get new_photo_url
    assert_response :success
    assert_equal "new", @controller.action_name
  end

  test "should get index if signed in" do
    user = User.new(user_id: "12345", password: "password")
    user.save
    post login_url(user_id: user.user_id, password: user.password)
    get photos_url
    assert_response :success
    assert_equal "index", @controller.action_name
  end

  test "should get show if signed in" do
    user = User.new(user_id: "1234", password: "password")
    user.save
    post login_url(user_id: user.user_id, password: user.password)

    photo = Photo.new(title: "Photo 1")
    photo.user = user
    photo.image.attach(io: File.open('./app/assets/images/photo-1.png'), filename: 'photo-1.png')
    photo.save

    get photo_url(photo)
    assert_response :success
    assert_equal "show", @controller.action_name
  end

  test "should get create" do
    user = User.new(user_id: "12345", password: "password")
    user.save
    post login_url(user_id: user.user_id, password: user.password)

    photo = Photo.new(title: "Photo 1")
    photo.user = user
    photo.image.attach(io: File.open('./app/assets/images/photo-1.png'), filename: 'photo-1.png')
    photo.save

    assert_redirected_to photos_path
    assert_equal "create", @controller.action_name
  end
end
