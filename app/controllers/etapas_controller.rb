class EtapasController < ApplicationController

	def index
		@etapa = Etapa.all
	end
	def new
		@etapa = Etapa.new
	end

	def show
	end

	def create
		@etapa = Etapa.new(etapa_params)

	    respond_to do |format|
	      if @etapa.save
	        format.html { redirect_to @etapa, notice: 'etapa was successfully created.' }
	        format.json { render :show, status: :created, location: @etapa }
	      else
	        format.html { render :new }
	        format.json { render json: @etapa.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private

	def set_etapa
	  @etapa = Etapa.find(params[:id])
	end
	
	def etapa_params
	  params.require(:etapa).permit(:nombre_etp, :tipo_etp, :competencia_id, :etapa_id)
	end
end