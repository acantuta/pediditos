class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.text :descripcion
      t.integer :precio
      t.references :entidad, index: true

      t.timestamps null: false
    end
    add_foreign_key :productos, :entidades
  end
end
