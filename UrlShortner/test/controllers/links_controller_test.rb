require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({ :provider => 'google_oauth2', info: { email: "test@example.com", name: "tester" }})
    @link = links(:one)
    get "/users/auth/google_oauth2"
    get "/users/auth/google_oauth2/callback", headers: {'omniauth.auth' => { email: "test@example.com", name: "tester"} }
  end

  test "should get index" do
    get links_url
    assert_response :success
  end

  test "should get new" do
    get new_link_url
    assert_response :success
  end

  test "should create link" do
    assert_difference('Link.count') do
      post links_url, params: { link: { source_link: @link.source_link+"2" } }
    end

    assert_redirected_to link_url(Link.last)
  end

  test "should show link" do
    get link_url(@link)
    assert_response :success
  end

  test "should destroy link" do
    assert_difference('Link.count', -1) do
      delete link_url(@link)
    end

    assert_redirected_to links_url
  end
end
