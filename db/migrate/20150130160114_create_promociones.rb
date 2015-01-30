class CreatePromociones < ActiveRecord::Migration
  def change
    create_table :promociones do |t|
      t.string :link      
      t.timestamps null: false
    end

    add_attachment :promociones, :avatar
  end

  def self.down
  	add_attachment :promociones, :avatar
  end
end
