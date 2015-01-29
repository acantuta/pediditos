class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy,:cambiar_estado]
  before_action :solo_usuario, except: [:confirmacion,:create]
  # GET /pedidos
  # GET /pedidos.json
  def index
    
    respond_to do |format|
      format.html
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show

  end

  # GET /pedidos/new
  def new
    @pedido = Pedido.new
  end

  # GET /pedidos/1/edit
  def edit
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    #@pedido = Pedido.new(pedido_params)
    flash = []

    ActiveRecord::Base.transaction do

      if @usuario
        usuario = @usuario
      else
        if pedido_identificacion_usuario_params

          codigo = Usuario.desconocido_codigo(dni_telefono_params[:dni], dni_telefono_params[:telefono])

          if not codigo.value.blank?
            if codigo.value == pedido_identificacion_usuario_params[:password]
              usuario = Usuario.create(pedido_identificacion_usuario_params)
            else 
              flash << {message: "Clave incorrecta.",type: 'alert'}
            end
          else
            flash << {message: "La clave ingresada ha expirado. Pida otra clave.",type: 'alert'}
          end

        end
      end


      
     if usuario
        @pedido = Pedido.new
        @pedido.entidad_id = params[:pedido][:entidad_id]
        @pedido.usuario_id = usuario.id
        
        @entidad = Entidad.find(@pedido.entidad_id)

        @pedido.direccion_entrega = params[:pedido][:direccion_entrega]
        @pedido.comentario = params[:pedido][:comentario]
        costo_total_productos = 0

        @pedido.save
        
          params[:pedido][:detalles].each do |detalle|
            producto = Producto.find(detalle[:id])
            d = Detallepedido.new
            d.producto_id = producto.id
            d.pedido_id = @pedido.id
            d.cantidad = detalle[:cantidad]
            d.costo_unit = producto.precio
            d.costo_total = d.cantidad * d.costo_unit
            costo_total_productos += d.costo_total
            d.save
          end
        @pedido.costo_total = costo_total_productos + @entidad.costo_delivery
        @pedido.save

        usuario.pedidos_no_atendidos_cache.value = Pedido.no_atendidos.where(usuario_id: usuario.id).count
        usuario.save

        guardar_sesion_usuario(usuario)
        flash << {
            message: "¡Pedido hecho! Espéranos mientras te atendemos.",
            type: 'success'
          }
      end
    end
  
    
    respond_to do |format|
      if @pedido and @pedido.persisted?
        format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
        format.json { render :show, status: :created, location: @pedido }
      else
        format.html { render :new }
        format.json { render json: {flash: flash}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    respond_to do |format|
      if @pedido.update(pedido_params)
        format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
        format.json { render :show, status: :ok, location: @pedido }
      else
        format.html { render :edit }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy

    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to pedidos_url, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirmacion
    render :layout => false
  end

  def listar

      
    if @usuario.es_admin?
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
          @pedidos = Pedido.no_atendidos.all
        end
    else
        if @usuario.tiene_entidad?
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
          @pedidos = @pedidos.where(usuario_id: @usuario.id).all
        else
          @pedidos = []
        end
    end
    
    respond_to do |format|      
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

  def cambiar_estado

    if Pedido.estados.include?(params[:nuevo_estado]) and not ['ATENDIDO','ANULADO'].include?(@pedido.estado)

      @pedido.estado = params[:nuevo_estado]

    end

    respond_to do |format|
      format.json{
        
          if @pedido.changed? and @pedido.save
            render :json => {

            }
          else
            render :json => {
              error: "No pudo actualizar el estado del pedido"
              },status: :unprocessable_entity
          end
        
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      params.require(:pedido).permit(:comentario, :direccion_entrega, :costo_total, :usuario_id, :entidad_id,:detalles)
    end

    def pedido_identificacion_usuario_params
      params.require(:usuario).permit(:dni,:telefono,:password,:nombre_completo)
    end

    def dni_telefono_params
      params.require(:usuario).permit(:dni,:telefono)
    end

end
