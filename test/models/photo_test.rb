require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  
  test "should save the photo with title and image" do
    user = User.new(user_id: "1234", password: "password")
    photo = Photo.new(title: "Photo 1")
    photo.user = user
    photo.image.attach(io: File.open('./app/assets/images/photo-1.png'), filename: 'photo-1.png')
    assert photo.save
  end

  test "should not save the photo without user" do
    photo = Photo.new(title: "Photo 1")
    photo.image.attach(io: File.open('./app/assets/images/photo-1.png'), filename: 'photo-1.png')
    assert_not photo.save
  end

  test "should not save the photo without title" do
    user = User.new(user_id: "1234", password: "password")
    photo = Photo.new(title: "Photo 1")
    photo.user = user
    assert_not photo.save
  end

  test "should not save the photo with title longer than 30 characteres" do
    user = User.new(user_id: "1234", password: "password")
    photo = Photo.new(title: "Photo 1234567890 1234567890 1234567890")
    photo.user = user
    photo.image.attach(io: File.open('./app/assets/images/photo-1.png'), filename: 'photo-1.png')
    assert_not photo.save
  end

  test "should not save the photo without image" do
    user = User.new(user_id: "1234", password: "password")
    photo = Photo.new
    photo.user = user
    photo.image.attach(io: File.open('./app/assets/images/photo-1.png'), filename: 'photo-1.png')
    assert_not photo.save
  end
end
