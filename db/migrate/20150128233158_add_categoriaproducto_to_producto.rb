class AddCategoriaproductoToProducto < ActiveRecord::Migration
  def change
    add_reference :productos, :categoriaproducto, index: true
    add_foreign_key :productos, :categoriaproductos
  end
end
