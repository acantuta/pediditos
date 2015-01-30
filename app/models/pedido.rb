class Pedido < ActiveRecord::Base
  include ActiveModel::Dirty
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

  after_save :after_grabar

  def after_grabar
    if self.changed?
      if self.estado_changed?
        if (self.estado_was == 'NUEVO' and 
          self.estado == 'PENDIENTE')

          usu = Usuario.find(self.usuario_id)
          if usu
            usu.enviar_sms("Ha recibido un pedido de su restaurante en #{Rails.application.config.domain}")
          end
        end
      end
    end
  end

  def self.estados
  	['NUEVO', 'PENDIENTE', 'ATENDIENDO', 'REPARTIENDO', 'ATENDIDO', 'ANULADO']
  end

  def es_admin
    
  end
end
