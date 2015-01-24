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
  $scope.$watch("entidad_id",function(v){
  	Pedido.entidad_id = v;
    $scope.cargar_entidad();
  });

  // Cargando restaurante y su detalle de productos.
  $scope.cargar_entidad = function(){
    $http.get('/restaurantes/'+$scope.entidad_id+".json").
	  success(function(data, status, headers, config) {
	    $scope.entidad = data;
	  }).
	  error(function(data, status, headers, config) {
	    alert("Ha sucedido un error al cargar menu.");
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
  	$scope.pedido.costo_total = total;
  }

  $scope.cambio_cantidad = function(producto){
    if(producto.cantidad>0){
      $scope.calcular_total_pedido();  
    }else{
      producto.cantidad = 1;
      $scope.calcular_total_pedido(); 
    }
  }

  $scope.confirmar_pedido = function(){
    $location.path("/pedidos/confirmacion");
  }


}]);
