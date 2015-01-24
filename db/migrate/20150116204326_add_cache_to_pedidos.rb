class AddCacheToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :cache, :string
  end
end
