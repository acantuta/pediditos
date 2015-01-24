class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
      t.text :comentario
      t.string :direccion_entrega
      t.integer :costo_total
      t.references :usuario, index: true
      t.references :entidad, index: true

      t.timestamps null: false
    end
    add_foreign_key :pedidos, :usuarios
    add_foreign_key :pedidos, :entidades
  end
end
