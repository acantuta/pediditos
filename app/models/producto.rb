class Producto < ActiveRecord::Base
  belongs_to :entidad
  belongs_to :categoriaproducto
  has_many :detallepedidos

  validates :descripcion, length: {maximum: 200},allow_blank: true
  validates :precio, presence: true

  acts_as_paranoid

  before_save{
  	self.visible ||= true
  }
  
  def precio_mascara
  	self.precio/100.00 if self.precio
  end
end
