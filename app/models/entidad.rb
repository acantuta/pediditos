class Entidad < ActiveRecord::Base
	belongs_to :categoriaentidad
	belongs_to :usuario
	has_many :productos
	has_many :categoriaproductos

	has_attached_file :avatar, styles: {
	    thumb: '100x100#',
	    square: '200x200#',
	    medium: '300x300#'
  	},:default_url => Rails.application.config.default_entidad_image
  	scope :visibles, -> { where(visible: true) }
  	default_scope{order(delivery_habilitado: :desc).order(updated_at: :desc)}

  	# Validate the attached image is image/jpg, image/png, etc
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def usuario_puede_editar?(usuario)
		(self.usuario_id == usuario.id or usuario.es_admin?)
	end
end
