class Producto < ActiveRecord::Base
  belongs_to :entidad
  has_many :detallepedidos
  validates :descripcion, length: {maximum: 200},allow_blank: true
end
