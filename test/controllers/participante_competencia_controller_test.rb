require 'test_helper'

class ParticipanteCompetenciaControllerTest < ActionController::TestCase
  setup do
    @participante_competencium = participante_competencia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participante_competencia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participante_competencium" do
    assert_difference('ParticipanteCompetencium.count') do
      post :create, participante_competencium: { cant_enc_jugados_par_com: @participante_competencium.cant_enc_jugados_par_com, cant_puntos_par_com: @participante_competencium.cant_puntos_par_com, cant_tarjetas_amar_par_com: @participante_competencium.cant_tarjetas_amar_par_com, cant_tarjetas_roja_par_com: @participante_competencium.cant_tarjetas_roja_par_com, competencia_id: @participante_competencium.competencia_id, enc_ganados_par_com: @participante_competencium.enc_ganados_par_com, enc_perdidos_par_com: @participante_competencium.enc_perdidos_par_com, enc_perdidos_par_com: @participante_competencium.enc_perdidos_par_com, goles_contra_par_com: @participante_competencium.goles_contra_par_com, goles_favor_par_com: @participante_competencium.goles_favor_par_com, grupo_par_com: @participante_competencium.grupo_par_com, participante_id: @participante_competencium.participante_id, total_enc_grupo_par_com: @participante_competencium.total_enc_grupo_par_com }
    end

    assert_redirected_to participante_competencium_path(assigns(:participante_competencium))
  end

  test "should show participante_competencium" do
    get :show, id: @participante_competencium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participante_competencium
    assert_response :success
  end

  test "should update participante_competencium" do
    patch :update, id: @participante_competencium, participante_competencium: { cant_enc_jugados_par_com: @participante_competencium.cant_enc_jugados_par_com, cant_puntos_par_com: @participante_competencium.cant_puntos_par_com, cant_tarjetas_amar_par_com: @participante_competencium.cant_tarjetas_amar_par_com, cant_tarjetas_roja_par_com: @participante_competencium.cant_tarjetas_roja_par_com, competencia_id: @participante_competencium.competencia_id, enc_ganados_par_com: @participante_competencium.enc_ganados_par_com, enc_perdidos_par_com: @participante_competencium.enc_perdidos_par_com, enc_perdidos_par_com: @participante_competencium.enc_perdidos_par_com, goles_contra_par_com: @participante_competencium.goles_contra_par_com, goles_favor_par_com: @participante_competencium.goles_favor_par_com, grupo_par_com: @participante_competencium.grupo_par_com, participante_id: @participante_competencium.participante_id, total_enc_grupo_par_com: @participante_competencium.total_enc_grupo_par_com }
    assert_redirected_to participante_competencium_path(assigns(:participante_competencium))
  end

  test "should destroy participante_competencium" do
    assert_difference('ParticipanteCompetencium.count', -1) do
      delete :destroy, id: @participante_competencium
    end

    assert_redirected_to participante_competencia_path
  end
end
