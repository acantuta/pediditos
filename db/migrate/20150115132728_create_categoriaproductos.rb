class CreateCategoriaproductos < ActiveRecord::Migration
  def change
    create_table :categoriaproductos do |t|
      t.string :nombre
      t.text :descripcion
      t.references :entidad, index: true

      t.timestamps null: false
    end
    add_foreign_key :categoriaproductos, :entidades
  end
end
