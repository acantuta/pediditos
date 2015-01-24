module ApplicationHelper
	def moneda(monto)
		if monto
			"S/. #{(monto/100.to_f)}"
		end
	end
end
