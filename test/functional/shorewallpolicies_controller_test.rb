require 'test_helper'

class ShorewallpoliciesControllerTest < ActionController::TestCase
  setup do
    @shorewallpolicy = shorewallpolicies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shorewallpolicies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shorewallpolicy" do
    assert_difference('Shorewallpolicy.count') do
      post :create, :shorewallpolicy => @shorewallpolicy.attributes
    end

    assert_redirected_to shorewallpolicy_path(assigns(:shorewallpolicy))
  end

  test "should show shorewallpolicy" do
    get :show, :id => @shorewallpolicy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @shorewallpolicy.to_param
    assert_response :success
  end

  test "should update shorewallpolicy" do
    put :update, :id => @shorewallpolicy.to_param, :shorewallpolicy => @shorewallpolicy.attributes
    assert_redirected_to shorewallpolicy_path(assigns(:shorewallpolicy))
  end

  test "should destroy shorewallpolicy" do
    assert_difference('Shorewallpolicy.count', -1) do
      delete :destroy, :id => @shorewallpolicy.to_param
    end

    assert_redirected_to shorewallpolicies_path
  end
end
