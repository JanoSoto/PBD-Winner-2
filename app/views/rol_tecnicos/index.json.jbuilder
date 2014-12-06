json.array!(@rol_tecnicos) do |rol_tecnico|
  json.extract! rol_tecnico, :id, :tipo_rol_tec
  json.url rol_tecnico_url(rol_tecnico, format: :json)
end
