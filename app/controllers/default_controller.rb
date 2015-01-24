class DefaultController < ApplicationController
	def index
		@categorias = Categoriaentidad.all	
	end
end
