class DefaultController < ApplicationController
	def index
		@categorias = Categoriaentidad.all	
		@entidades = Entidad.all.first(3)
	end
end
