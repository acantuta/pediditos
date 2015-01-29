class AddUsuarioToEntidades < ActiveRecord::Migration
  def change
    add_reference :entidades, :usuario, index: true
    add_foreign_key :entidades, :usuarios
  end
end
