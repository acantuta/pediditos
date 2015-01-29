class CategoriaproductosController < ApplicationController
  before_action :set_categoriaproducto, only: [:show, :edit, :update, :destroy]

  # GET /categoriaproductos
  # GET /categoriaproductos.json
  def index
    @categoriaproductos = Categoriaproducto.all
  end

  # GET /categoriaproductos/1
  # GET /categoriaproductos/1.json
  def show
  end

  # GET /categoriaproductos/new
  def new
    @categoriaproducto = Categoriaproducto.new(categoriaproducto_params)
  end

  # GET /categoriaproductos/1/edit
  def edit
  end

  # POST /categoriaproductos
  # POST /categoriaproductos.json
  def create
    @categoriaproducto = Categoriaproducto.new(categoriaproducto_params)

    respond_to do |format|
      if @categoriaproducto.save

        #Actualiza los anteriores productos a este nuevo grupo por defecto
        Producto.where(entidad_id: @categoriaproducto.entidad_id, categoriaproducto_id: nil).update_all(categoriaproducto_id: @categoriaproducto.id)
        
        format.html { redirect_to entidad_path(@categoriaproducto.entidad_id) , notice: 'Categoriaproducto was successfully created.' }
        format.json { render :show, status: :created, location: @categoriaproducto }
      else
        format.html { render :new }
        format.json { render json: @categoriaproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categoriaproductos/1
  # PATCH/PUT /categoriaproductos/1.json
  def update
    respond_to do |format|
      if @categoriaproducto.update(categoriaproducto_params)
        format.html { redirect_to entidad_path(@categoriaproducto.entidad_id), notice: 'Categoriaproducto was successfully updated.' }
        format.json { render :show, status: :ok, location: @categoriaproducto }
      else
        format.html { render :edit }
        format.json { render json: @categoriaproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categoriaproductos/1
  # DELETE /categoriaproductos/1.json
  def destroy
    @categoriaproducto.destroy
    respond_to do |format|
      format.html { redirect_to categoriaproductos_url, notice: 'Categoriaproducto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoriaproducto
      @categoriaproducto = Categoriaproducto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categoriaproducto_params
      params.require(:categoriaproducto).permit(:nombre, :descripcion, :entidad_id)
    end
end
