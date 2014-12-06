class EncuentrosController < ApplicationController
  before_action :set_encuentro, only: [:show, :edit, :update, :destroy]

  # GET /encuentros
  # GET /encuentros.json
  def index
    @encuentros = Encuentro.all
  end

  # GET /encuentros/1
  # GET /encuentros/1.json
  def show
  end

  # GET /encuentros/new
  def new
    @encuentro = Encuentro.new
  end

  # GET /encuentros/1/edit
  def edit
  end

  # POST /encuentros
  # POST /encuentros.json
  def create
    @encuentro = Encuentro.new(encuentro_params)

    respond_to do |format|
      if @encuentro.save
        format.html { redirect_to @encuentro, notice: 'Encuentro was successfully created.' }
        format.json { render :show, status: :created, location: @encuentro }
      else
        format.html { render :new }
        format.json { render json: @encuentro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encuentros/1
  # PATCH/PUT /encuentros/1.json
  def update
    respond_to do |format|
      if @encuentro.update(encuentro_params)
        format.html { redirect_to @encuentro, notice: 'Encuentro was successfully updated.' }
        format.json { render :show, status: :ok, location: @encuentro }
      else
        format.html { render :edit }
        format.json { render json: @encuentro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encuentros/1
  # DELETE /encuentros/1.json
  def destroy
    @encuentro.destroy
    respond_to do |format|
      format.html { redirect_to encuentros_url, notice: 'Encuentro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encuentro
      @encuentro = Encuentro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encuentro_params
      params.require(:encuentro).permit(:fecha_enc, :tiro_libre_local_enc, :tiro_esquina_local_enc, :fuera_de_juego_local_enc, :tiro_libre_visita_enc, :tiro_esquina_visita_enc, :fuera_de_juego_visita_enc, :duracion_enc, :cant_publico_enc, :gol_local_enc, :gol_visita_enc, :def_penales_enc, :estado_enc)
    end
end
