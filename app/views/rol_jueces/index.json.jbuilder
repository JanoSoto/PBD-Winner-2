json.array!(@rol_jueces) do |rol_juece|
  json.extract! rol_juece, :id, :tipo_rol_juez
  json.url rol_juece_url(rol_juece, format: :json)
end
