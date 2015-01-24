require 'test_helper'

class DetallepedidosControllerTest < ActionController::TestCase
  setup do
    @detallepedido = detallepedidos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:detallepedidos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create detallepedido" do
    assert_difference('Detallepedido.count') do
      post :create, detallepedido: { cantidad: @detallepedido.cantidad, comentario: @detallepedido.comentario, costo_total: @detallepedido.costo_total, costo_unit: @detallepedido.costo_unit, pedido_id: @detallepedido.pedido_id, producto_id: @detallepedido.producto_id }
    end

    assert_redirected_to detallepedido_path(assigns(:detallepedido))
  end

  test "should show detallepedido" do
    get :show, id: @detallepedido
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @detallepedido
    assert_response :success
  end

  test "should update detallepedido" do
    patch :update, id: @detallepedido, detallepedido: { cantidad: @detallepedido.cantidad, comentario: @detallepedido.comentario, costo_total: @detallepedido.costo_total, costo_unit: @detallepedido.costo_unit, pedido_id: @detallepedido.pedido_id, producto_id: @detallepedido.producto_id }
    assert_redirected_to detallepedido_path(assigns(:detallepedido))
  end

  test "should destroy detallepedido" do
    assert_difference('Detallepedido.count', -1) do
      delete :destroy, id: @detallepedido
    end

    assert_redirected_to detallepedidos_path
  end
end
