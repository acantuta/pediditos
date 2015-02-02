app.controller("ConfirmacionPedido",['$scope','$http','Pedido','Usuario',function($scope,$http,Pedido,Usuario){
	$scope.identificacion = {};
  $scope.usuario = Usuario; 

	$scope.$watch('identificacion',function(v){
		console.log("cambio identificación.");
		console.log($scope.submit_habilitado);
		$scope.submit_habilitado = $scope.puede_hacer_pedido();
    $scope.flash = [];
	},true);

  $scope.$watch("identificacion.dni", function(v){
    if(v && v.length == 8){
        $scope.verificar_existencia_usuario();
    }
  });

  $scope.$watch("identificacion.telefono", function(v){
    if(v && v.length == 9){
        $scope.enviar_sms();
    }
  });


  $scope.verificar_existencia_usuario = function(){
    $http({
      method: 'POST',
      url: '/usuarios/existe-usuario.json',
      data: {
        usuario:{
          dni: $scope.identificacion.dni
        }
      }
    }).success(function(data){
      $scope.existe_usuario = true;
    }).error(function(){  
      $scope.existe_usuario = false;
    });
  }

	$scope.puede_hacer_pedido = function(){
  		var r = false;
  		if(($scope.identificacion.dni && $scope.identificacion.dni.length>0 
  			&& $scope.identificacion.telefono && $scope.identificacion.telefono.length>0 
  			&& $scope.identificacion.password && $scope.identificacion.password.length>0) || ($scope.usuario && $scope.usuario.conectado ) )
  		{
  			r = true;
  		}
  		return r;
  	}

	$scope.enviar_sms = function(){
	  $http(
	  		{
	  			url: "/usuarios/enviar_sms.json",
	  			method: "POST",
	  			data: {
	  				usuario:$scope.identificacion
	  			}
	  		}
	  	)
	    .success(function($data){

	    }
	    )
	    .error(function(){

	    }
	   	);
	}

	$scope.realizar_pedido = function(){
      $scope.flash = [];
  	  $http({
  		url: "/pedidos.json",
  		method: 'POST',
  		data: {
  			pedido: Pedido,
  			usuario: $scope.identificacion
  		}
  	  }).success(function(data){
  	  	$scope.flash = data.flash;
  	  	console.log($scope.flash);
  	  	console.log(data);
  	  	$('#confirmacion-pedido').foundation('reveal', 'close');
  	  	Pedido.limpiar();
        Usuario.cargar();
        alert("¡Se hizo el pedido exitosamente. Lo atenderemos lo más pronto posible!");
  	  }).error(function(data,status){        
  	  	if(data && data.flash){
  	  		$scope.flash = data.flash;
  	  		console.log($scope.flash);	
  	  	}else{
  	  		$scope.flash = []
  	  		$scope.flash.push({
  	  			message: 'Error en el servidor',
  	  			alert: 'alert'
  	  		})
  	  	}
  	  	
  	  	console.log(data);
  	  });
  	}

  	

  	
/*
  	$scope.$watch("identificacion.telefono",function(v){
	  if(v && v.length==9){
	    $scope.enviar_sms();
	  }
	});*/
	
  
}]);