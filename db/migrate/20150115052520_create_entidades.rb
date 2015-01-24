class CreateEntidades < ActiveRecord::Migration
  def change
    create_table :entidades do |t|
      t.string :nombre
      t.text :descripcion
      t.integer :tiempo_envio_aprox
      t.integer :costo_delivery
      t.integer :pedido_minimo

      t.timestamps null: false
    end
  end
end
