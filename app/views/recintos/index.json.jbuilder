json.array!(@recintos) do |recinto|
  json.extract! recinto, :id, :nombre_rec, :ciudad_rec, :pais_rec, :capacidad_rec
  json.url recinto_url(recinto, format: :json)
end
