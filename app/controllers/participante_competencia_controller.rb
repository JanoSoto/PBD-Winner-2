class ParticipanteCompetenciaController < ApplicationController
  before_action :set_participante_competencium, only: [:show, :edit, :update, :destroy]

  # GET /participante_competencia
  # GET /participante_competencia.json
  def index
    @participante_competencia = ParticipanteCompetencium.all
  end

  # GET /participante_competencia/1
  # GET /participante_competencia/1.json
  def show
  end

  # GET /participante_competencia/new
  def new
    @participante_competencium = ParticipanteCompetencium.new
  end

  # GET /participante_competencia/1/edit
  def edit
  end

  # POST /participante_competencia
  # POST /participante_competencia.json
  def create
    @participante_competencium = ParticipanteCompetencium.new(participante_competencium_params)

    respond_to do |format|
      if @participante_competencium.save
        format.html { redirect_to @participante_competencium, notice: 'Participante competencium was successfully created.' }
        format.json { render :show, status: :created, location: @participante_competencium }
      else
        format.html { render :new }
        format.json { render json: @participante_competencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participante_competencia/1
  # PATCH/PUT /participante_competencia/1.json
  def update
    respond_to do |format|
      if @participante_competencium.update(participante_competencium_params)
        format.html { redirect_to @participante_competencium, notice: 'Participante competencium was successfully updated.' }
        format.json { render :show, status: :ok, location: @participante_competencium }
      else
        format.html { render :edit }
        format.json { render json: @participante_competencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participante_competencia/1
  # DELETE /participante_competencia/1.json
  def destroy
    @participante_competencium.destroy
    respond_to do |format|
      format.html { redirect_to participante_competencia_url, notice: 'Participante competencium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participante_competencium
      @participante_competencium = ParticipanteCompetencium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participante_competencium_params
      params.require(:participante_competencium).permit(:competencia_id, :participante_id, :enc_ganados_par_com, :enc_perdidos_par_com, :enc_perdidos_par_com, :goles_favor_par_com, :goles_contra_par_com, :cant_tarjetas_amar_par_com, :cant_tarjetas_roja_par_com, :cant_puntos_par_com, :cant_enc_jugados_par_com, :grupo_par_com, :total_enc_grupo_par_com)
    end
end
