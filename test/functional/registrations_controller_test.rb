require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    login(users(:admin))
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  test "an admin should be able to create new user" do
    assert_difference('User.count') do
      post :create, :user => {:first_name => 'First Name', :last_name => 'Last Name', :status => 'active', :email => 'new_registration@example.com',
        :steering_committee => true, :steering_committee_secretary => false, :pp_committee => false, :pp_committee_secretary => false, :system_admin => false}
    end
  
    assert_redirected_to user_path(assigns(:user))
  end
end
