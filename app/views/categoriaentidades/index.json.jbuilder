json.array!(@categoriaentidades) do |categoriaentidad|
  json.extract! categoriaentidad, :id, :nombre, :descripcion
  json.url categoriaentidad_url(categoriaentidad, format: :json)
end
