class DetallepedidosController < ApplicationController
  before_action :set_detallepedido, only: [:show, :edit, :update, :destroy]

  # GET /detallepedidos
  # GET /detallepedidos.json
  def index
    @detallepedidos = Detallepedido.all
  end

  # GET /detallepedidos/1
  # GET /detallepedidos/1.json
  def show
  end

  # GET /detallepedidos/new
  def new
    @detallepedido = Detallepedido.new
  end

  # GET /detallepedidos/1/edit
  def edit
  end

  # POST /detallepedidos
  # POST /detallepedidos.json
  def create
    @detallepedido = Detallepedido.new(detallepedido_params)

    respond_to do |format|
      if @detallepedido.save
        format.html { redirect_to @detallepedido, notice: 'Detallepedido was successfully created.' }
        format.json { render :show, status: :created, location: @detallepedido }
      else
        format.html { render :new }
        format.json { render json: @detallepedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detallepedidos/1
  # PATCH/PUT /detallepedidos/1.json
  def update
    respond_to do |format|
      if @detallepedido.update(detallepedido_params)
        format.html { redirect_to @detallepedido, notice: 'Detallepedido was successfully updated.' }
        format.json { render :show, status: :ok, location: @detallepedido }
      else
        format.html { render :edit }
        format.json { render json: @detallepedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detallepedidos/1
  # DELETE /detallepedidos/1.json
  def destroy
    @detallepedido.destroy
    respond_to do |format|
      format.html { redirect_to detallepedidos_url, notice: 'Detallepedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detallepedido
      @detallepedido = Detallepedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def detallepedido_params
      params.require(:detallepedido).permit(:cantidad, :costo_unit, :costo_total, :comentario, :producto_id, :pedido_id)
    end
end
