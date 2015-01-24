json.array!(@pedidos) do |pedido|
  json.extract! pedido, :id, :comentario, :direccion_entrega, :costo_total, :usuario_id, :entidad_id
  json.url pedido_url(pedido, format: :json)
end
