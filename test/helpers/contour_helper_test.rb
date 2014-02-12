require 'test_helper'

class ContourHelperTest < ActionView::TestCase

  test "should show sort field helper" do
    params[:controller] = 'welcome'
    params[:action] = 'index'
    assert sort_field_helper("first_name DESC", "last_name", "First Name").kind_of?(String)
  end

  test "should show sort field helper with same order" do
    params[:controller] = 'welcome'
    params[:action] = 'index'
    assert sort_field_helper("first_name", "first_name", "First Name").kind_of?(String)
  end

end
