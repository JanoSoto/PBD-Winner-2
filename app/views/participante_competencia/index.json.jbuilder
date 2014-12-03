json.array!(@participante_competencia) do |participante_competencium|
  json.extract! participante_competencium, :id, :competencia_id, :participante_id, :enc_ganados_par_com, :enc_perdidos_par_com, :enc_perdidos_par_com, :goles_favor_par_com, :goles_contra_par_com, :cant_tarjetas_amar_par_com, :cant_tarjetas_roja_par_com, :cant_puntos_par_com, :cant_enc_jugados_par_com, :grupo_par_com, :total_enc_grupo_par_com
  json.url participante_competencium_url(participante_competencium, format: :json)
end
