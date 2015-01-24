app.controller('PedidosController',['$scope','$http',function($scope,$http){
	
	$scope.$watch('estado',function(){
		$scope.cargar_pedidos();
	});

	$scope.mirar_pedidos = function(){
		angular.forEach($scope.pedidos,function(v,k){
			$watch()
		});
	}

	$scope.cargar_pedidos = function(){
		$http({
			method: 'GET',
			url: '/pedidos/listar-' + $scope.estado + '.json'
		}).success(function(data){
			$scope.pedidos = data;
			console.log($scope.pedidos);
		}).error(function(data){

		});
	}

	$scope.init = function(){
		$scope.cargar_pedidos();
		$scope.set_estado('no-atendidos')
	}

	$scope.set_estado = function(valor){
		$scope.estado = valor;
	}

	$scope.cambiar_estado_pedido = function(pedido, nuevo_estado){
		console.log("cambiando...");
		$http({
			method: 'POST',
			url: "pedidos/"+pedido.id+"/cambiar-estado.json",
			data:{
				nuevo_estado: nuevo_estado
			}
		}).success(function(data){
			pedido.estado = nuevo_estado;			
		}).error(function(data){
			alert("Ha sucedido un error al intentar cambiar el estado del pedido.")
			$scope.cargar_pedidos();
		});
	}


	$scope.init();
	
}]);