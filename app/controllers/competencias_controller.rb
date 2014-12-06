class CompetenciasController < ApplicationController

	def index
		@competencia = Competencia.all
	end
	def new
		@competencia = Competencia.new
	end

	def show
	end

	def create
		@competencia = Competencia.new(competencia_params)

	    respond_to do |format|
	      if @competencia.save
	        format.html { redirect_to @competencia, notice: 'competencia was successfully created.' }
	        format.json { render :show, status: :created, location: @competencia }
	      else
	        format.html { render :new }
	        format.json { render json: @competencia.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private

	def set_competencia
	  @competencia = competencia.find(params[:id])
	end

	def competencia_params
	  params.require(:competencia).permit(:nombre_comp, :descripcion_comp, :tipo_comp, :ida_vuelta_comp, :cant_part_comp, :fecha_inicio_comp, :fecha_termino_comp, :cant_grupos_comp, :cant_fases_comp, :cant_arbitros_comp, :cant_jug_tit, :cant_jug_ban, :cant_max_jug_comp, :cant_mod_comp, :privacidad_comp, :organizador_id)
	end
end