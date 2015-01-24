class AddAvatarToEntidades < ActiveRecord::Migration
  def self.up
  	add_attachment :entidades, :avatar
  end

  def self.down
  	remove_attachment :entidades, :avatar
  end
end
