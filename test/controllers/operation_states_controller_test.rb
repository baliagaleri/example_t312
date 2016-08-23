require 'test_helper'

class OperationStatesControllerTest < ActionController::TestCase
  setup do
    @operation_state = operation_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operation_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operation_state" do
    assert_difference('OperationState.count') do
      post :create, operation_state: { name: @operation_state.name }
    end

    assert_redirected_to operation_state_path(assigns(:operation_state))
  end

  test "should show operation_state" do
    get :show, id: @operation_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation_state
    assert_response :success
  end

  test "should update operation_state" do
    patch :update, id: @operation_state, operation_state: { name: @operation_state.name }
    assert_redirected_to operation_state_path(assigns(:operation_state))
  end

  test "should destroy operation_state" do
    assert_difference('OperationState.count', -1) do
      delete :destroy, id: @operation_state
    end

    assert_redirected_to operation_states_path
  end
end
