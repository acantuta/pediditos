# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
	inflect.irregular 'usuario', 'usuarios'
	inflect.irregular 'entidad', 'entidades'
	inflect.irregular 'categoriaproducto', 'categoriaproductos'
	inflect.irregular 'producto', 'productos'
	inflect.irregular 'pedido', 'pedidos'
	inflect.irregular 'detallepedido', 'detallepedidos'
	inflect.irregular 'categoriaentidad', 'categoriaentidades'
	inflect.irregular 'promocion', 'promociones'
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
