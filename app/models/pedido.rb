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
  before_save :before_grabar

  def before_grabar
    if self.new_record?
      usu_admin = Usuario.find(Rails.application.config.usuario_id_admin)
      usu_admin.enviar_sms("Hay un pedido nuevo en #{Rails.application.config.domain}")
    end
  end

  def after_grabar    

    if self.changed?
      if self.estado_changed?
        if (self.estado_was == 'NUEVO' and 
          self.estado == 'PENDIENTE')
          enti = Entidad.find(self.entidad_id)
          usu = Usuario.find(enti.usuario_id) if enti.usuario_id          
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
