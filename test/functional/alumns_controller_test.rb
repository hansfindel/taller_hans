require 'test_helper'

class AlumnsControllerTest < ActionController::TestCase
  setup do
    @alumn = alumns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alumns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alumn" do
    assert_difference('Alumn.count') do
      post :create, alumn: @alumn.attributes
    end

    assert_redirected_to alumn_path(assigns(:alumn))
  end

  test "should show alumn" do
    get :show, id: @alumn.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alumn.to_param
    assert_response :success
  end

  test "should update alumn" do
    put :update, id: @alumn.to_param, alumn: @alumn.attributes
    assert_redirected_to alumn_path(assigns(:alumn))
  end

  test "should destroy alumn" do
    assert_difference('Alumn.count', -1) do
      delete :destroy, id: @alumn.to_param
    end

    assert_redirected_to alumns_path
  end
end
