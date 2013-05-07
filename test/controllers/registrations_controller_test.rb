require 'test_helper'

class Contour::RegistrationsControllerTest < ActionController::TestCase
  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "a new user should be able to sign up" do
    assert_difference('User.count') do
      post :create, user: { first_name: 'First Name', last_name: 'Last Name', email: 'new_user@example.com', password: 'password', password_confirmation: 'password', spam: '' }
    end

    assert_not_nil assigns(:user)
    assert_equal 'First Name', assigns(:user).first_name
    assert_equal 'Last Name', assigns(:user).last_name
    assert_equal 'pending', assigns(:user).status
    assert_equal 'new_user@example.com', assigns(:user).email

    assert_redirected_to new_user_session_path
  end

  test "a new user should not be able to set their status" do
    assert_difference('User.count') do
      post :create, user: { first_name: 'First Name', last_name: 'Last Name', status: 'active', email: 'new_registration@example.com', password: 'password', password_confirmation: 'password' }
    end

    assert_not_nil assigns(:user)
    assert_equal 'First Name', assigns(:user).first_name
    assert_equal 'Last Name', assigns(:user).last_name
    assert_equal 'pending', assigns(:user).status
    assert_equal 'new_registration@example.com', assigns(:user).email

    assert_redirected_to new_user_session_path
  end

  test "a submitter spam bot should not be able to sign up" do
    assert_difference('User.count', 0) do
      post :create, user: { first_name: 'First Name', last_name: 'Last Name', email: 'new_user@example.com', password: 'password', password_confirmation: 'password', spam: 'http://buystuffhere.com' }
    end

    assert_equal 'Thank you for your interest! Due to limited capacity you have been put on a waiting list. We will email you when we open up additional space.', flash[:notice]

    assert_redirected_to new_user_session_path
  end

  # test "a new user should be able to sign up via JSON" do
  #   assert_difference('User.count') do
  #     post :create, user: { first_name: 'First Name', last_name: 'Last Name', email: 'new_user_json@example.com', password: 'password', password_confirmation: 'password' }, format: 'json'
  #   end

  #   assert_not_nil assigns(:user)
  #   assert_equal 'First Name', assigns(:user).first_name
  #   assert_equal 'Last Name', assigns(:user).last_name
  #   assert_equal 'pending', assigns(:user).status
  #   assert_equal 'new_user_json@example.com', assigns(:user).email

  #   user = JSON.parse(@response.body)
  #   assert_equal assigns(:user).id, user['id']
  #   assert_equal assigns(:user).email, user['email']
  #   assert_equal assigns(:user).first_name, user['first_name']
  #   assert_equal assigns(:user).last_name, user['last_name']
  #   assert_equal assigns(:user).authentication_token, user['authentication_token']

  #   assert_response :success
  # end

  # test "an admin should be able to create new user" do
  #   login(users(:admin))
  #   assert_difference('User.count') do
  #     post :create, user: { first_name: 'First Name', last_name: 'Last Name', status: 'active', email: 'new_registration@example.com', system_admin: false }
  #   end

  #   assert_not_nil assigns(:user)
  #   assert_equal 'First Name', assigns(:user).first_name
  #   assert_equal 'Last Name', assigns(:user).last_name
  #   assert_equal 'active', assigns(:user).status
  #   assert_equal 'new_registration@example.com', assigns(:user).email

  #   assert_redirected_to user_path(assigns(:user))
  # end
end
