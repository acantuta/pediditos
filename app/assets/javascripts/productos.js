$(document).on("ready",function(){
	$(".form-producto #producto_precio_mascara").on("change",function(){
		var valor = $(this).val() * 100;
		$(".form-producto #producto_precio").val(valor);
	});
});
