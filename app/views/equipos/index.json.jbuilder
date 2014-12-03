json.array!(@equipos) do |equipo|
  json.extract! equipo, :id, :encuentro_id, :convocatoria_id, :equ_citado
  json.url equipo_url(equipo, format: :json)
end
