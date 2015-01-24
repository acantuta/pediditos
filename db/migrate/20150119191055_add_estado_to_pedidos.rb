class AddEstadoToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :estado, :string,:default => 'NUEVO'
  end
end
