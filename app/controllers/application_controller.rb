class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter {
  	@es_admin = true
    @nombre_sitio = Rails.application.config.nombre_sitio
    @usuario = session[:usuario] if session[:usuario]
  }

  before_filter :envolver_usuario

  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def envolver_usuario
    if session[:usuario]
      @usuario = Usuario.find(session[:usuario]["id"])
    end
  end
  
  def solo_admin
      redirect_to "/" if not (@usuario and @usuario.es_admin?)
  end

  def solo_usuario
    if not @usuario
      if params[:format] != 'html'
        render text: 'Sin autorización',:status => :unautorized
      else
        redirect_to "/usuarios/login"
      end
    end
  end

  def solo_usuario_entidad
    if not (@usuario and @usuario.tiene_entidad?)
      if params[:format] != 'html'
        render text: 'Sin autorización',:status => :unautorized
      else
        redirect_to "/usuarios/login"
      end
    end
  end

  

  def guardar_sesion_usuario(usuario)
    session[:usuario] = usuario
  end
  protected
    # In Rails 4.2 and above
    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end
  
end
