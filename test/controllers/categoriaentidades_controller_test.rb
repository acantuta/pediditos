require 'test_helper'

class CategoriaentidadesControllerTest < ActionController::TestCase
  setup do
    @categoriaentidad = categoriaentidades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categoriaentidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categoriaentidad" do
    assert_difference('Categoriaentidad.count') do
      post :create, categoriaentidad: { descripcion: @categoriaentidad.descripcion, nombre: @categoriaentidad.nombre }
    end

    assert_redirected_to categoriaentidad_path(assigns(:categoriaentidad))
  end

  test "should show categoriaentidad" do
    get :show, id: @categoriaentidad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categoriaentidad
    assert_response :success
  end

  test "should update categoriaentidad" do
    patch :update, id: @categoriaentidad, categoriaentidad: { descripcion: @categoriaentidad.descripcion, nombre: @categoriaentidad.nombre }
    assert_redirected_to categoriaentidad_path(assigns(:categoriaentidad))
  end

  test "should destroy categoriaentidad" do
    assert_difference('Categoriaentidad.count', -1) do
      delete :destroy, id: @categoriaentidad
    end

    assert_redirected_to categoriaentidades_path
  end
end
