class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :solo_usuario_propio, only: [:edit,:update]
  before_action :solo_admin, except: [:edit,:update,:login,:autenticar,:enviar_sms,:salir,:recordar_clave,:existe_usuario]
  
  

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usu = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usu = Usuario.new(usuario_params)
    respond_to do |format|
      if @usu.save
        format.html { redirect_to @usu, notice: 'Usuario was successfully created.' }
        format.json { render :show, status: :created, location: @usu }
      else
        format.html { render :new }
        format.json { render json: @usu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    respond_to do |format|
      if @usu.update(usuario_params)
        format.html { redirect_to @usu, notice: 'Usuario was successfully updated.' }
        format.json { render :show, status: :ok, location: @usu }
      else
        format.html { render :edit }
        format.json { render json: @usu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usu.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Usuario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def enviar_sms
    if usuario_sms_params[:dni] and usuario_sms_params[:telefono]
      r = Usuario.desconocido_codigo(usuario_sms_params[:dni],usuario_sms_params[:telefono])
      if r.value.blank?
        r.value = Usuario.generar_clave
      end 
      mensaje_sms = "#{@nombre_sitio} - Su clave es: #{r.value}"
      puts mensaje_sms
      Usuario.enviar_sms(mensaje_sms,usuario_sms_params[:telefono])
    end 

      respond_to do |format|
        format.html{
          redirect_to "usuarios/login"
        }

        format.json{
          render json: ({mensaje:"mensaje enviado"})
        }
      end
  end

  def login
    
  end

  def autenticar
    usuario = Usuario.where(dni: params[:dni]).take
    if usuario and usuario.authenticate params[:clave]
      guardar_sesion_usuario(usuario)
      redirect_to "/"
    else
      redirect_to '/usuarios/login'
    end
  end

  def salir
    reset_session
    redirect_to '/'
  end

  def mis_pedidos
    
  end

  def recordar_clave
    usuario = Usuario.where(dni: params[:dni]).take
    if usuario
      usuario.clave_temporal.value = Usuario.generar_clave
      usuario.password = usuario.clave_temporal.value.to_s
      usuario.save
      puts 'clave emporal es:'
      puts usuario.clave_temporal.value
      mensaje = "#{@nombre_sitio} - Tu clave es #{usuario.clave_temporal.value}"
      usuario.enviar_sms(mensaje)
      return redirect_to "/usuarios/login"
    end
  end
  
  def existe_usuario
    us = Usuario.where(dni: params[:usuario][:dni]).take
    respond_to do |format|
      format.json{
          if us
            render json: {existe: true}
          else
            render json:{existe: false} ,status: :unprocessable_entity
          end
      }

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usu = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:nombre_completo, :dni, :telefono, :direccion, :email,:entidad_id,:password)
    end

    def usuario_sms_params
      params.require(:usuario).permit(:dni,:telefono)
    end

    def solo_usuario_propio
      if not ((@usu.id == @usuario.id) or @usuario.es_admin?)
        if params[:format] != 'html'
          render text: 'Sin autorización',:status => :unautorized
        else
          redirect_to "/usuarios/login"
        end
      end
    end
end
