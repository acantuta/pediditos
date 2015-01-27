class Entidad < ActiveRecord::Base
	belongs_to :categoriaentidad
	has_many :productos

	has_attached_file :avatar, styles: {
	    thumb: '100x100>',
	    square: '200x200>',
	    medium: '300x300>'
  	},:default_url => Rails.application.config.default_entidad_image

  	 default_scope{order(updated_at: :desc)}

  	# Validate the attached image is image/jpg, image/png, etc
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def usuario_puede_editar?(usuario)
		(self.id==usuario.entidad_id or usuario.es_admin?)
	end
end
