require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "existing user" do
    user = User.from_omniauth(OmniAuth::AuthHash.new({ :provider => 'google_oauth2', info: { email: "example@example.com"}}))
    assert_equal "one", user.name
  end
  
  test "new user" do
    assert_equal 2, User.count
    user = User.from_omniauth(OmniAuth::AuthHash.new({ :provider => 'google_oauth2', info: { email: "test@example.com", name: "tester" }}))
    assert_equal 3, User.count
  end
end
