require 'test_helper'

class EncuentrosControllerTest < ActionController::TestCase
  setup do
    @encuentro = encuentros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:encuentros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create encuentro" do
    assert_difference('Encuentro.count') do
      post :create, encuentro: { cant_publico_enc: @encuentro.cant_publico_enc, def_penales_enc: @encuentro.def_penales_enc, duracion_enc: @encuentro.duracion_enc, estado_enc: @encuentro.estado_enc, fecha_enc: @encuentro.fecha_enc, fuera_de_juego_local_enc: @encuentro.fuera_de_juego_local_enc, fuera_de_juego_visita_enc: @encuentro.fuera_de_juego_visita_enc, gol_local_enc: @encuentro.gol_local_enc, gol_visita_enc: @encuentro.gol_visita_enc, tiro_esquina_local_enc: @encuentro.tiro_esquina_local_enc, tiro_esquina_visita_enc: @encuentro.tiro_esquina_visita_enc, tiro_libre_local_enc: @encuentro.tiro_libre_local_enc, tiro_libre_visita_enc: @encuentro.tiro_libre_visita_enc }
    end

    assert_redirected_to encuentro_path(assigns(:encuentro))
  end

  test "should show encuentro" do
    get :show, id: @encuentro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @encuentro
    assert_response :success
  end

  test "should update encuentro" do
    patch :update, id: @encuentro, encuentro: { cant_publico_enc: @encuentro.cant_publico_enc, def_penales_enc: @encuentro.def_penales_enc, duracion_enc: @encuentro.duracion_enc, estado_enc: @encuentro.estado_enc, fecha_enc: @encuentro.fecha_enc, fuera_de_juego_local_enc: @encuentro.fuera_de_juego_local_enc, fuera_de_juego_visita_enc: @encuentro.fuera_de_juego_visita_enc, gol_local_enc: @encuentro.gol_local_enc, gol_visita_enc: @encuentro.gol_visita_enc, tiro_esquina_local_enc: @encuentro.tiro_esquina_local_enc, tiro_esquina_visita_enc: @encuentro.tiro_esquina_visita_enc, tiro_libre_local_enc: @encuentro.tiro_libre_local_enc, tiro_libre_visita_enc: @encuentro.tiro_libre_visita_enc }
    assert_redirected_to encuentro_path(assigns(:encuentro))
  end

  test "should destroy encuentro" do
    assert_difference('Encuentro.count', -1) do
      delete :destroy, id: @encuentro
    end

    assert_redirected_to encuentros_path
  end
end
