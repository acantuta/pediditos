// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require confirmacionpedido

app.controller('EntidadesController', ['$scope', '$http', 'Pedido', '$location','Usuario', function($scope, $http, Pedido, $location,Usuario){

  $scope.pedido = Pedido;
  $scope.usuario = Usuario;
  $scope.esta_cargando = false;
  $scope.pedido_es_visible = false;
  $scope.$watch("entidad_id",function(v){
  	Pedido.entidad_id = v;
    $scope.cargar_entidad();
  });

  // Cargando restaurante y su detalle de productos.
  $scope.cargar_entidad = function(){
    $scope.esta_cargando = true;
    $http.get('/restaurantes/'+$scope.entidad_id+".json").
	  success(function(data, status, headers, config) {
	    $scope.entidad = data;
      $scope.esta_cargando = false;
	  }).
	  error(function(data, status, headers, config) {
	    //alert("Ha sucedido un error al cargar menu.");
      $scope.esta_cargando = false;
	});
  }
  
  $scope.agregar_producto = function(producto){	  	
	for(var i  in $scope.pedido.detalles){
	  if($scope.pedido.detalles[i].id==producto.id){
	  	$scope.pedido.detalles[i].cantidad +=1;
	  	$scope.calcular_total_pedido();
	  	return false;
	  	}
	}
	producto.cantidad = 1;
	$scope.pedido.detalles.push(producto);
	$scope.calcular_total_pedido();
	console.log(Pedido);
  }

  $scope.quitar_producto = function(producto){
  	for(var i  in $scope.pedido.detalles){
  		if($scope.pedido.detalles[i].id==producto.id){	  			
  			$scope.pedido.detalles.splice(i,1);
  		}
  	}
  	$scope.calcular_total_pedido();
  }

  $scope.calcular_total_pedido = function(){
  	var total = 0;
  	for(var i  in $scope.pedido.detalles){
      $scope.pedido.detalles[i].total = $scope.pedido.detalles[i].precio * $scope.pedido.detalles[i].cantidad;
  		total += $scope.pedido.detalles[i].precio * $scope.pedido.detalles[i].cantidad;
  	}
    var costo_total = total + $scope.entidad.costo_delivery;
  	$scope.pedido.costo_total = costo_total;
  }

  $scope.cambio_cantidad = function(producto){
    if(producto.cantidad>=0){
      $scope.calcular_total_pedido();  
    }else{
      producto.cantidad = 0;
      $scope.calcular_total_pedido(); 
    }
  }

  $scope.confirmar_pedido = function(){
    $location.path("/pedidos/confirmacion");
  }

  $scope.eliminar_producto = function(producto){
    if(confirm("¿ Estás seguro de eliminarlo ?")){
      $http({
        method: "delete",
        url: "/productos/" + producto.id + ".json"
      }).success(function(){
        producto.visible = false;
      }).error(function(){
        alert("Sucedió un error al eliminar")
      });
    }
  }

  $scope.es_pedido_valido = function(){
    var r = false;
    if($scope.pedido && $scope.pedido.detalles.length>0){
      if($scope.pedido.direccion_entrega && $scope.pedido.direccion_entrega.length>0){
        r = true;
      }
    }
    return r;
  }

  $scope.ver_pedido = function(){
    $('html, body').animate({
        scrollTop: $("#pedido_temporal").offset().top
    }, 1000);
  }

  $scope.init = function(){
    
    $(window).on('DOMContentLoaded load resize scroll', function(){
      $scope.pedido_es_visible = $("#pedido_temporal").isOnScreen(0.05,0.05);
      $scope.$apply();
    }); 
  }

  $scope.es_visible_boton_ver_pedido = function(){
    return (!$scope.pedido_es_visible 
      && $scope.pedido && $scope.pedido.detalles.length>0);
  }
  $scope.init();
}]);
