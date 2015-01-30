class PromocionesController < ApplicationController
  before_action :set_promocion, only: [:show, :edit, :update, :destroy]

  # GET /promociones
  # GET /promociones.json
  def index
    @promociones = Promocion.all
  end

  # GET /promociones/1
  # GET /promociones/1.json
  def show
  end

  # GET /promociones/new
  def new
    @promocion = Promocion.new
  end

  # GET /promociones/1/edit
  def edit
  end

  # POST /promociones
  # POST /promociones.json
  def create
    @promocion = Promocion.new(promocion_params)

    respond_to do |format|
      if @promocion.save
        format.html { redirect_to @promocion, notice: 'Promocion was successfully created.' }
        format.json { render :show, status: :created, location: @promocion }
      else
        format.html { render :new }
        format.json { render json: @promocion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promociones/1
  # PATCH/PUT /promociones/1.json
  def update
    respond_to do |format|
      if @promocion.update(promocion_params)
        format.html { redirect_to @promocion, notice: 'Promocion was successfully updated.' }
        format.json { render :show, status: :ok, location: @promocion }
      else
        format.html { render :edit }
        format.json { render json: @promocion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promociones/1
  # DELETE /promociones/1.json
  def destroy
    @promocion.destroy
    respond_to do |format|
      format.html { redirect_to promociones_url, notice: 'Promocion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promocion
      @promocion = Promocion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promocion_params
      params.require(:promocion).permit(:link,:avatar)
    end
end
