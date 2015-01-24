require 'test_helper'

class EntidadesControllerTest < ActionController::TestCase
  setup do
    @entidad = entidades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entidad" do
    assert_difference('Entidad.count') do
      post :create, entidad: { costo_delivery: @entidad.costo_delivery, descripcion: @entidad.descripcion, nombre: @entidad.nombre, pedido_minimo: @entidad.pedido_minimo, tiempo_envio_aprox: @entidad.tiempo_envio_aprox }
    end

    assert_redirected_to entidad_path(assigns(:entidad))
  end

  test "should show entidad" do
    get :show, id: @entidad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entidad
    assert_response :success
  end

  test "should update entidad" do
    patch :update, id: @entidad, entidad: { costo_delivery: @entidad.costo_delivery, descripcion: @entidad.descripcion, nombre: @entidad.nombre, pedido_minimo: @entidad.pedido_minimo, tiempo_envio_aprox: @entidad.tiempo_envio_aprox }
    assert_redirected_to entidad_path(assigns(:entidad))
  end

  test "should destroy entidad" do
    assert_difference('Entidad.count', -1) do
      delete :destroy, id: @entidad
    end

    assert_redirected_to entidades_path
  end
end
