app.controller('PedidoController',['$scope','$http',function($scope,$http){
	$scope.$watch("pedido_id",function(v){
			$http({
				url: "/pedidos/"+v+".json"
				})
				.success(function(data){
					$scope.pedido = data;
				})
				.error(function(){

				});
		}
	);
	
}]);