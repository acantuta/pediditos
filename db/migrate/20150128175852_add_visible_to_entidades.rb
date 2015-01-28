class AddVisibleToEntidades < ActiveRecord::Migration
  def change
    add_column :entidades, :visible, :boolean
  end
end
