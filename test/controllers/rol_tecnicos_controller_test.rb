require 'test_helper'

class RolTecnicosControllerTest < ActionController::TestCase
  setup do
    @rol_tecnico = rol_tecnicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rol_tecnicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rol_tecnico" do
    assert_difference('RolTecnico.count') do
      post :create, rol_tecnico: { tipo_rol_tec: @rol_tecnico.tipo_rol_tec }
    end

    assert_redirected_to rol_tecnico_path(assigns(:rol_tecnico))
  end

  test "should show rol_tecnico" do
    get :show, id: @rol_tecnico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rol_tecnico
    assert_response :success
  end

  test "should update rol_tecnico" do
    patch :update, id: @rol_tecnico, rol_tecnico: { tipo_rol_tec: @rol_tecnico.tipo_rol_tec }
    assert_redirected_to rol_tecnico_path(assigns(:rol_tecnico))
  end

  test "should destroy rol_tecnico" do
    assert_difference('RolTecnico.count', -1) do
      delete :destroy, id: @rol_tecnico
    end

    assert_redirected_to rol_tecnicos_path
  end
end
