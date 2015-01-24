json.array!(@detallepedidos) do |detallepedido|
  json.extract! detallepedido, :id, :cantidad, :costo_unit, :costo_total, :comentario, :producto_id, :pedido_id
  json.url detallepedido_url(detallepedido, format: :json)
end
