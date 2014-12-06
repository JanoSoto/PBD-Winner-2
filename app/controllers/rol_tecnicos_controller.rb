class RolTecnicosController < ApplicationController
  before_action :set_rol_tecnico, only: [:show, :edit, :update, :destroy]

  # GET /rol_tecnicos
  # GET /rol_tecnicos.json
  def index
    @rol_tecnicos = RolTecnico.all
  end

  # GET /rol_tecnicos/1
  # GET /rol_tecnicos/1.json
  def show
  end

  # GET /rol_tecnicos/new
  def new
    @rol_tecnico = RolTecnico.new
  end

  # GET /rol_tecnicos/1/edit
  def edit
  end

  # POST /rol_tecnicos
  # POST /rol_tecnicos.json
  def create
    @rol_tecnico = RolTecnico.new(rol_tecnico_params)

    respond_to do |format|
      if @rol_tecnico.save
        format.html { redirect_to @rol_tecnico, notice: 'Rol tecnico was successfully created.' }
        format.json { render :show, status: :created, location: @rol_tecnico }
      else
        format.html { render :new }
        format.json { render json: @rol_tecnico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rol_tecnicos/1
  # PATCH/PUT /rol_tecnicos/1.json
  def update
    respond_to do |format|
      if @rol_tecnico.update(rol_tecnico_params)
        format.html { redirect_to @rol_tecnico, notice: 'Rol tecnico was successfully updated.' }
        format.json { render :show, status: :ok, location: @rol_tecnico }
      else
        format.html { render :edit }
        format.json { render json: @rol_tecnico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rol_tecnicos/1
  # DELETE /rol_tecnicos/1.json
  def destroy
    @rol_tecnico.destroy
    respond_to do |format|
      format.html { redirect_to rol_tecnicos_url, notice: 'Rol tecnico was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rol_tecnico
      @rol_tecnico = RolTecnico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rol_tecnico_params
      params.require(:rol_tecnico).permit(:tipo_rol_tec)
    end
end
