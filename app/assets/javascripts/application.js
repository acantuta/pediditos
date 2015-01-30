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
//= require jquery
//= require jquery_ujs
//= require angular
//= require angular-route
//= require foundation
//= require productos



$(function(){ 
  $(document).foundation();
  $(document).foundation('tab', 'reflow');
});

var app = angular.module('App',['ngRoute']);


app.config(['$routeProvider',function($routeProvider){
  $routeProvider
    .when('/pedidos/confirmacion',{
    	controller: 'ConfirmacionPedido',
    	templateUrl: '/pedidos/confirmacion'
    }).otherwise({redirect_to:'/'});
}]);
app.factory('Pedido',['$http',function($http){
  	var pedido = {
  		entidad_id: null,
  		detalles:[],
  		costo_total:0,
      direccion_entrega: null,
      limpiar: function(){
        this.detalles = [],
        this.costo_total = 0;
      }
  	}

  	return pedido;
  }]);

app.factory("Usuario",["$http",function($http){
  var usuario = {}
  usuario.pedidos_no_atendidos = 0;

  usuario.set_data = function(data){
    usuario.pedidos_no_atendidos = data.pedidos_no_atendidos;
    usuario.conectado = true;
  }

  usuario.cargar = function(){
    $http({
      method: 'GET',
      url: '/yo.json'
    })
    .success(function(data){
      usuario.set_data(data);
    })
    .error(function(){

    })
  };


  
  usuario.cargar_pedidos_espera = function(){

  }
  return usuario;
}]);

app.filter('moneda',function(){
  return function(moneda) {
    if(moneda){
      var soles = (moneda/100).toFixed(2)
      return "S/."+soles;  
    }else{
      return "";
    }
    
  };
})

app.controller("Topbar",['$http','$scope','Usuario',function($http,$scope,Usuario){
  $scope.usuario = Usuario;
  $scope.usuario.cargar();
}]);

app.run(function(){
  $(".loader").hide();
});


(function ($) {

    $.fn.isOnScreen = function(x, y){

        if(x == null || typeof x == 'undefined') x = 1;
        if(y == null || typeof y == 'undefined') y = 1;

        var win = $(window);

        var viewport = {
            top : win.scrollTop(),
            left : win.scrollLeft()
        };
        viewport.right = viewport.left + win.width();
        viewport.bottom = viewport.top + win.height();

        var height = this.outerHeight();
        var width = this.outerWidth();

        if(!width || !height){
            return false;
        }

        var bounds = this.offset();
        bounds.right = bounds.left + width;
        bounds.bottom = bounds.top + height;

        var visible = (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom));

        if(!visible){
            return false;
        }

        var deltas = {
            top : Math.min( 1, ( bounds.bottom - viewport.top ) / height),
            bottom : Math.min(1, ( viewport.bottom - bounds.top ) / height),
            left : Math.min(1, ( bounds.right - viewport.left ) / width),
            right : Math.min(1, ( viewport.right - bounds.left ) / width)
        };

        return (deltas.left * deltas.right) >= x && (deltas.top * deltas.bottom) >= y;

    };

})(jQuery);