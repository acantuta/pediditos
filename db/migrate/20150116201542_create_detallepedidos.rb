class CreateDetallepedidos < ActiveRecord::Migration
  def change
    create_table :detallepedidos do |t|
      t.integer :cantidad
      t.integer :costo_unit
      t.integer :costo_total
      t.text :comentario
      t.references :producto, index: true
      t.references :pedido, index: true

      t.timestamps null: false
    end
    add_foreign_key :detallepedidos, :productos
    add_foreign_key :detallepedidos, :pedidos
  end
end
