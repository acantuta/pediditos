class DefaultController < ApplicationController
	def index
		@categorias = Categoriaentidad.all	
		@entidades = Entidad.visibles.all.first(3)
	end
end
