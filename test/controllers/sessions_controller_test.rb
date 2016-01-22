require 'test_helper'

# Tests to for API response for successful logins
class Contour::SessionsControllerTest < ActionController::TestCase
  setup do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'return user json object on login' do
    post :create, params: { user: { email: users(:valid).email, password: 'password' }, format: 'json' }
    object = JSON.parse(@response.body)
    assert_equal true, object['success']
    assert_equal users(:valid).id, object['user']['id']
    assert_equal 'FirstName', object['user']['first_name']
    assert_equal 'LastName', object['user']['last_name']
    assert_equal 'valid@example.com', object['user']['email']
    assert object['user'].keys.include?('authentication_token')
    assert_response :success
  end

  test 'should not login invalid credentials' do
    post :create, params: { user: { email: '', password: '' } }

    assert_response :success
  end
end
