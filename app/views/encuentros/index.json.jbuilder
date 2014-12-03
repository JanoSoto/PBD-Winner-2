json.array!(@encuentros) do |encuentro|
  json.extract! encuentro, :id, :fecha_enc, :tiro_libre_local_enc, :tiro_esquina_local_enc, :fuera_de_juego_local_enc, :tiro_libre_visita_enc, :tiro_esquina_visita_enc, :fuera_de_juego_visita_enc, :duracion_enc, :cant_publico_enc, :gol_local_enc, :gol_visita_enc, :def_penales_enc, :estado_enc
  json.url encuentro_url(encuentro, format: :json)
end
