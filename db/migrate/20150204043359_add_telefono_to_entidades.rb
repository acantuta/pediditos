class AddTelefonoToEntidades < ActiveRecord::Migration
  def change
    add_column :entidades, :telefono, :string
  end
end
