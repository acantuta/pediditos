class AddAvatarToCategoriaproducto < ActiveRecord::Migration
  def self.up
  	add_attachment :categoriaproductos, :avatar
  end

  def self.down
  	remove_attachment :categoriaproductos, :avatar
  end
end
