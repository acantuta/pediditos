class Categoriaproducto < ActiveRecord::Base
  belongs_to :entidad
  has_many :productos
  has_attached_file :avatar, styles: {
	    full: '650x150#',
	    medium: '325x75#'	    
  },default_url: ''
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def avatar_url
  	avatar.url(:full)
  end

end
