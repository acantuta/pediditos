json.array!(@entidades) do |entidad|
  json.extract! entidad, :id, :nombre, :descripcion, :tiempo_envio_aprox, :costo_delivery, :pedido_minimo, :telefono
  json.url entidad_url(entidad, format: :json)
end
