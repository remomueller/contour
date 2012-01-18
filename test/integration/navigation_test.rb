require 'test_helper'

SimpleCov.command_name "test:integration"

class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @valid = users(:valid)
    @pending = users(:pending)
    @deleted = users(:deleted)
  end

  test "pending users should be not be allowed to login" do
    get "/logged_in_page"
    assert_redirected_to new_user_session_path

    sign_in_as(@pending, "123456", "pending-2@example.com")
    assert_equal new_user_session_path, path
    assert_equal I18n.t('devise.failure.inactive'), flash[:alert]
  end

  test "deleted users should be not be allowed to login" do
    get "/logged_in_page"
    assert_redirected_to new_user_session_path

    sign_in_as(@deleted, "123456", "deleted-2@example.com")
    assert_equal new_user_session_path, path
    assert_equal I18n.t('devise.failure.inactive'), flash[:alert]
  end

  test "root navigation redirected to login page" do
    get "/"
    assert_redirected_to new_user_session_path
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end

  test "friendly url forwarding after login" do
    get "/logged_in_page"
    assert_redirected_to new_user_session_path

    sign_in_as(@valid, "123456", "valid-2@example.com")
    assert_equal '/logged_in_page', path
    assert_equal I18n.t('devise.sessions.signed_in'), flash[:notice]
  end
  
  test "valid users should be able to login using basic http" do
    get logged_in_page_path( format: :json ), {}, "HTTP_AUTHORIZATION" => "Basic #{Base64.encode64("#{users(:valid).email}:password")}"
    assert_equal({ name: 'Name', count: 5 }.to_json, @response.body)
    assert_response :success
  end
  
  test "valid users should not be able to login using basic http and wrong password" do
    get logged_in_page_path( format: :json ), {}, "HTTP_AUTHORIZATION" => "Basic #{Base64.encode64("#{users(:valid).email}:wrongpassword")}"
    assert_equal({ error: "Invalid email or password." }.to_json, @response.body)
    assert_response 401
  end
end