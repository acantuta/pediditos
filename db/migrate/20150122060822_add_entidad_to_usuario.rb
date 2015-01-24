class AddEntidadToUsuario < ActiveRecord::Migration
  def change
    add_reference :usuarios, :entidad, index: true
    add_foreign_key :usuarios, :entidades
  end
end
