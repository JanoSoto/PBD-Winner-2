require 'test_helper'

class JugadorsControllerTest < ActionController::TestCase
  setup do
    @jugador = jugadors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jugadors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jugador" do
    assert_difference('Jugador.count') do
      post :create, jugador: { apellido_mat_jug: @jugador.apellido_mat_jug, apellido_pat_jug: @jugador.apellido_pat_jug, email_jug: @jugador.email_jug, fecha_nac_jug: @jugador.fecha_nac_jug, foto_jug: @jugador.foto_jug, nombre_jug: @jugador.nombre_jug, rut_jug: @jugador.rut_jug, sexo_jug: @jugador.sexo_jug }
    end

    assert_redirected_to jugador_path(assigns(:jugador))
  end

  test "should show jugador" do
    get :show, id: @jugador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jugador
    assert_response :success
  end

  test "should update jugador" do
    patch :update, id: @jugador, jugador: { apellido_mat_jug: @jugador.apellido_mat_jug, apellido_pat_jug: @jugador.apellido_pat_jug, email_jug: @jugador.email_jug, fecha_nac_jug: @jugador.fecha_nac_jug, foto_jug: @jugador.foto_jug, nombre_jug: @jugador.nombre_jug, rut_jug: @jugador.rut_jug, sexo_jug: @jugador.sexo_jug }
    assert_redirected_to jugador_path(assigns(:jugador))
  end

  test "should destroy jugador" do
    assert_difference('Jugador.count', -1) do
      delete :destroy, id: @jugador
    end

    assert_redirected_to jugadors_path
  end
end
