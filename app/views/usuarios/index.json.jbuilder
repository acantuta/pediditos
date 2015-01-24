json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :nombre_completo, :dni, :telefono, :direccion, :email
  json.url usuario_url(usuario, format: :json)
end
