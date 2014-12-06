json.array!(@tecnicos) do |tecnico|
  json.extract! tecnico, :id, :nombre_tec, :apellido_pat_tec, :apellido_mat_tec, :rut_tec, :sexo_tec, :fecha_nac_tec, :email_tec, :foto_tec
  json.url tecnico_url(tecnico, format: :json)
end
