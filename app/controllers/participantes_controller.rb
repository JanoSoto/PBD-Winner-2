class ParticipantesController < ApplicationController

	def index
		@participante = Participante.all
	end
	def new
		@participante = Participante.new
	end

	def show
	end

	def create
		@participante = Participante.new(participante_params)

	    respond_to do |format|
	      if @participante.save
	        format.html { redirect_to @participante, notice: 'participante was successfully created.' }
	        format.json { render :show, status: :created, location: @participante }
	      else
	        format.html { render :new }
	        format.json { render json: @participante.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private

	def set_participante
	  @participante = Participante.find(params[:id])
	end

	def participante_params
	  params.require(:participante).permit(:nombre_par, :pais_par)
	end
end