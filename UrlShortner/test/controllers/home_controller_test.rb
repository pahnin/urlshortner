require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({ :provider => 'google_oauth2', info: { email: "test@example.com", name: "tester" }})
    @link = links(:one)
    get "/users/auth/google_oauth2"
    get "/users/auth/google_oauth2/callback", headers: {'omniauth.auth' => { email: "test@example.com", name: "tester"} }
  end

  test "Updating the key" do
    assert_nil User.where(email: "test@example.com").first.key

    get updatekey_path

    assert_not_nil User.where(email: "test@example.com").first.key
  end

  test "short code redirection" do

    get "/u/MyString2"
    assert_redirected_to "example.com/123"
  end
end
