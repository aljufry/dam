require 'test_helper'

class SnmpControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

end
