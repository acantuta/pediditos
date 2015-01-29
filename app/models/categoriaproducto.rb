class Categoriaproducto < ActiveRecord::Base
  belongs_to :entidad
  has_many :productos
end
