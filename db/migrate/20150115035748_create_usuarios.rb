class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre_completo
      t.string :dni
      t.string :telefono
      t.string :direccion
      t.string :email

      t.timestamps null: false
    end
  end
end
