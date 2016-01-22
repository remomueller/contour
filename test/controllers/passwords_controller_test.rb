require 'test_helper'

# Tests for requesting and resetting a password
class Contour::PasswordsControllerTest < ActionController::TestCase
  setup do
    # login(users(:admin))
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'should be able to view forget password' do
    get :new
    assert_response :success
  end

  test 'should be able to request new password' do
    post :create, params: { user: { email: 'valid@example.com' } }
    assert_equal I18n.t('devise.passwords.send_instructions'), flash[:notice]
    assert_redirected_to new_user_session_path
  end
end
