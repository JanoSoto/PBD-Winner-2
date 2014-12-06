json.array!(@jueces) do |juece|
  json.extract! juece, :id, :nombre_juez, :apellido_pat_juez, :apellido_mat_juez, :rut_juez, :sexo_juez, :fecha_nac_juez, :email_juez, :foto_juez
  json.url juece_url(juece, format: :json)
end
