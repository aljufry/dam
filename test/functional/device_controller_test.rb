require 'test_helper'

class DeviceControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get _form" do
    get :_form
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

end
