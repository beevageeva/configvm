require 'test_helper'

class ShorewallrulesControllerTest < ActionController::TestCase
  setup do
    @shorewallrule = shorewallrules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shorewallrules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shorewallrule" do
    assert_difference('Shorewallrule.count') do
      post :create, :shorewallrule => @shorewallrule.attributes
    end

    assert_redirected_to shorewallrule_path(assigns(:shorewallrule))
  end

  test "should show shorewallrule" do
    get :show, :id => @shorewallrule.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @shorewallrule.to_param
    assert_response :success
  end

  test "should update shorewallrule" do
    put :update, :id => @shorewallrule.to_param, :shorewallrule => @shorewallrule.attributes
    assert_redirected_to shorewallrule_path(assigns(:shorewallrule))
  end

  test "should destroy shorewallrule" do
    assert_difference('Shorewallrule.count', -1) do
      delete :destroy, :id => @shorewallrule.to_param
    end

    assert_redirected_to shorewallrules_path
  end
end
