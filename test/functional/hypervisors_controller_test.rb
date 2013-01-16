require 'test_helper'

class HypervisorsControllerTest < ActionController::TestCase
  setup do
    @hypervisor = hypervisors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hypervisors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hypervisor" do
    assert_difference('Hypervisor.count') do
      post :create, :hypervisor => @hypervisor.attributes
    end

    assert_redirected_to hypervisor_path(assigns(:hypervisor))
  end

  test "should show hypervisor" do
    get :show, :id => @hypervisor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @hypervisor.to_param
    assert_response :success
  end

  test "should update hypervisor" do
    put :update, :id => @hypervisor.to_param, :hypervisor => @hypervisor.attributes
    assert_redirected_to hypervisor_path(assigns(:hypervisor))
  end

  test "should destroy hypervisor" do
    assert_difference('Hypervisor.count', -1) do
      delete :destroy, :id => @hypervisor.to_param
    end

    assert_redirected_to hypervisors_path
  end
end
