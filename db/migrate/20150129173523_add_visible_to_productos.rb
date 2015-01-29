class AddVisibleToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :visible, :boolean
  end
end
