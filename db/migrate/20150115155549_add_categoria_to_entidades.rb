class AddCategoriaToEntidades < ActiveRecord::Migration
  def change
    add_reference :entidades, :categoriaentidad, index: true
    add_foreign_key :entidades, :categoriaentidades
  end
end
