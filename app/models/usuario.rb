class Usuario < ActiveRecord::Base
	include Redis::Objects
	has_many :pedidos
	has_secure_password
	belongs_to :usuario

	#redis fields
	value :pedidos_no_atendidos_cache
	value :clave_temporal, expiration: 60*30

	validates :dni, uniqueness: true
	def enviar_sms(texto)

	  if Rails.application.config.sms_habilitado
	    resource = RestClient::Resource.new(Rails.application.config.sms_api, Rails.application.config.sms_auth_id, Rails.application.config.sms_auth_token)
        begin
          t=resource.post({src: Rails.application.config.sms_src_number,dst: "#{Rails.application.config.sms_prefix}#{self.telefono}",text: texto}.to_json,:content_type => 'application/json')
          puts "result enviando SMS"
          puts t
        rescue=>e
	      p e
        end
      else
      	puts 'Sms está deshabilitado'
      end
	end

	def self.enviar_sms(texto,telefono)

	  if Rails.application.config.sms_habilitado
	    resource = RestClient::Resource.new(Rails.application.config.sms_api, Rails.application.config.sms_auth_id, Rails.application.config.sms_auth_token)
        begin
          resource.post({src: Rails.application.config.sms_src_number,dst: "#{Rails.application.config.sms_prefix}#{telefono}",text: texto}.to_json,:content_type => 'application/json')
        rescue=>e
	      p e
        end
      else
      	puts 'Sms está deshabilitado'
      end

	end

	def self.es_admin?(usuario_id)
		(Rails.application.config.usuario_id_admin == usuario_id.to_s)
	end

	def es_admin?
		(Rails.application.config.usuario_id_admin == self.id.to_s)
	end

	def pedidos_no_atendidos		
		if self.pedidos_no_atendidos_cache and self.pedidos_no_atendidos_cache.value
			return self.pedidos_no_atendidos_cache 
		else 
			return 0
		end
	end
	def as_json(options = { })
	    super((options || { }).merge({
	        :methods => [:pedidos_no_atendidos]
	    }))
	end

	def tiene_entidad?
		(not self.id.blank?)
	end

	def self.generar_clave
		return rand(1000..9999).to_s
	end

	def self.desconocido_codigo(dni,telefono)
		r = Redis::Value.new("desconocido:#{dni}:#{telefono}:codigo")
		expireat = (Time.now + (60*20).seconds).to_i
        r.expireat(expireat)
        return r
	end
end
