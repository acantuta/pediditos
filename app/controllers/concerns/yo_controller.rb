class YoController < ApplicationController
	before_action :solo_usuario
	before_action :solo_usuario_entidad, only: [:mis_pedidos_recibidos]
	def index
		respond_to do |format|
			format.html
			format.json{
				render json: @usuario
			}
		end
	end
	def show
		
	end
	def mis_pedidos
		@pedidos = Pedido.eager_load(:detallepedidos => :producto).where(:usuario_id => @usuario.id)
		respond_to do |format|
			format.html
			format.json{
				render json: @pedidos,:include => [:detallepedidos]
			}
		end
	end

	def mis_pedidos_recibidos
		@pedidos = nil
	    case params[:tipo]
	    when 'nuevos' 
	        @pedidos = Pedido.nuevos.all
	    when 'pendientes'
	      @pedidos = Pedido.pendientes.all
	    when 'atendiendo'
	      @pedidos = Pedido.atendiendo.all
	    when 'repartiendo'
	      @pedidos = Pedido.repartiendo.all
	    when 'atendidos'
	      @pedidos = Pedido.atendidos.all
	    when 'anulados'
	      @pedidos = Pedido.anulados.all
	    when 'no-atendidos'
	      @pedidos = Pedido.no_atendidos_sin_nuevo.all
	    end

	    if @pedidos
	    	@pedidos = @pedidos.where(entidad_id: @usuario.entidad_id)
	    else 
	    	@pedidos = []
	    end

	    respond_to do |format|
	    	format.html{
	    		
	    	}
	    	format.json{
	    		render json: @pedidos, :include => [
		          {
		            :detallepedidos=>{
		              :include => [:producto=>{
		                only: [:nombre,:descripcion]
		                }]}},
		            :usuario => {
		              only: [:nombre_completo,:dni,:telefono]
		            }
		          ]
	    	}
	    end
	end
end