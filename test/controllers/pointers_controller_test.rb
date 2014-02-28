require 'test_helper'

class PointersControllerTest < ActionController::TestCase
  setup do
    @pointer = pointers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pointers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pointer" do
    assert_difference('Pointer.count') do
      post :create, pointer: { contact_id: @pointer.contact_id, type: @pointer.type, value: @pointer.value }
    end

    assert_redirected_to pointer_path(assigns(:pointer))
  end

  test "should show pointer" do
    get :show, id: @pointer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pointer
    assert_response :success
  end

  test "should update pointer" do
    patch :update, id: @pointer, pointer: { contact_id: @pointer.contact_id, type: @pointer.type, value: @pointer.value }
    assert_redirected_to pointer_path(assigns(:pointer))
  end

  test "should destroy pointer" do
    assert_difference('Pointer.count', -1) do
      delete :destroy, id: @pointer
    end

    assert_redirected_to pointers_path
  end
end
