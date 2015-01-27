class AddDeleteAtToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :deleted_at, :datetime
    add_index :productos, :deleted_at
  end
end
