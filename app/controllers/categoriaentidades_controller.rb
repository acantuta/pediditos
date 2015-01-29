class CategoriaentidadesController < ApplicationController
  before_action :set_categoriaentidad, only: [:show, :edit, :update, :destroy]

  # GET /categoriaentidades
  # GET /categoriaentidades.json
  def index
    @categoriaentidades = Categoriaentidad.all

  end

  # GET /categoriaentidades/1
  # GET /categoriaentidades/1.json
  def show
    @entidades = @categoriaentidad.entidades
    render "entidades/index"
  end

  # GET /categoriaentidades/new
  def new
    @categoriaentidad = Categoriaentidad.new
  end

  # GET /categoriaentidades/1/edit
  def edit
  end

  # POST /categoriaentidades
  # POST /categoriaentidades.json
  def create
    
    @categoriaentidad = Categoriaentidad.new(categoriaentidad_params)
  
    respond_to do |format|
      if @categoriaentidad.save
        format.html { redirect_to @categoriaentidad, notice: 'Categoriaentidad was successfully created.' }
        format.json { render :show, status: :created, location: @categoriaentidad }
      else
        format.html { render :new }
        format.json { render json: @categoriaentidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categoriaentidades/1
  # PATCH/PUT /categoriaentidades/1.json
  def update
    respond_to do |format|
      if @categoriaentidad.update(categoriaentidad_params)
        format.html { redirect_to @categoriaentidad, notice: 'Categoriaentidad was successfully updated.' }
        format.json { render :show, status: :ok, location: @categoriaentidad }
      else
        format.html { render :edit }
        format.json { render json: @categoriaentidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categoriaentidades/1
  # DELETE /categoriaentidades/1.json
  def destroy
    @categoriaentidad.destroy
    respond_to do |format|
      format.html { redirect_to categoriaentidades_url, notice: 'Categoriaentidad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoriaentidad
      @categoriaentidad = Categoriaentidad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categoriaentidad_params
      params.require(:categoriaentidad).permit(:nombre, :descripcion)
    end
end
