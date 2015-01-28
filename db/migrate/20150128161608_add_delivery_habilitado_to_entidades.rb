class AddDeliveryHabilitadoToEntidades < ActiveRecord::Migration
  def change
    add_column :entidades, :delivery_habilitado, :boolean
  end
end
