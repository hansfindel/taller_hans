require 'test_helper'

class ProfesorsControllerTest < ActionController::TestCase
  setup do
    @profesor = profesors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profesors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profesor" do
    assert_difference('Profesor.count') do
      post :create, profesor: @profesor.attributes
    end

    assert_redirected_to profesor_path(assigns(:profesor))
  end

  test "should show profesor" do
    get :show, id: @profesor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profesor.to_param
    assert_response :success
  end

  test "should update profesor" do
    put :update, id: @profesor.to_param, profesor: @profesor.attributes
    assert_redirected_to profesor_path(assigns(:profesor))
  end

  test "should destroy profesor" do
    assert_difference('Profesor.count', -1) do
      delete :destroy, id: @profesor.to_param
    end

    assert_redirected_to profesors_path
  end
end
