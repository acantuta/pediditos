class Pedido < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :entidad
  has_many :detallepedidos
  scope :nuevos, -> { where(estado: 'NUEVO') }
  scope :pendientes, -> { where(estado: 'PENDIENTE') }
  scope :atendiendo, -> { where(estado: 'ATENDIENDO') }
  scope :repartiendo, -> { where(estado: 'REPARTIENDO') }
  scope :atendidos, -> { where(estado: 'ATENDIDO') }
  scope :anulados, -> { where(estado: 'ANULADO') }
  scope :no_atendidos, -> { where(estado: ['NUEVO','PENDIENTE','ATENDIENDO','REPARTIENDO']) }
  scope :no_atendidos_sin_nuevo, -> { where(estado: ['PENDIENTE','ATENDIENDO','REPARTIENDO']) }

  def self.estados
  	['NUEVO', 'PENDIENTE', 'ATENDIENDO', 'REPARTIENDO', 'ATENDIDO', 'ANULADO']
  end

  def es_admin
    
  end
end
