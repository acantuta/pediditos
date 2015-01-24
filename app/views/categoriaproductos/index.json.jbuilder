json.array!(@categoriaproductos) do |categoriaproducto|
  json.extract! categoriaproducto, :id, :nombre, :descripcion, :entidad_id
  json.url categoriaproducto_url(categoriaproducto, format: :json)
end
