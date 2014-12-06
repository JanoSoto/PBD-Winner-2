class RolJuecesController < ApplicationController
  before_action :set_rol_juece, only: [:show, :edit, :update, :destroy]

  # GET /rol_jueces
  # GET /rol_jueces.json
  def index
    @rol_jueces = RolJuece.all
  end

  # GET /rol_jueces/1
  # GET /rol_jueces/1.json
  def show
  end

  # GET /rol_jueces/new
  def new
    @rol_juece = RolJuece.new
  end

  # GET /rol_jueces/1/edit
  def edit
  end

  # POST /rol_jueces
  # POST /rol_jueces.json
  def create
    @rol_juece = RolJuece.new(rol_juece_params)

    respond_to do |format|
      if @rol_juece.save
        format.html { redirect_to @rol_juece, notice: 'Rol juece was successfully created.' }
        format.json { render :show, status: :created, location: @rol_juece }
      else
        format.html { render :new }
        format.json { render json: @rol_juece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rol_jueces/1
  # PATCH/PUT /rol_jueces/1.json
  def update
    respond_to do |format|
      if @rol_juece.update(rol_juece_params)
        format.html { redirect_to @rol_juece, notice: 'Rol juece was successfully updated.' }
        format.json { render :show, status: :ok, location: @rol_juece }
      else
        format.html { render :edit }
        format.json { render json: @rol_juece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rol_jueces/1
  # DELETE /rol_jueces/1.json
  def destroy
    @rol_juece.destroy
    respond_to do |format|
      format.html { redirect_to rol_jueces_url, notice: 'Rol juece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rol_juece
      @rol_juece = RolJuece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rol_juece_params
      params.require(:rol_juece).permit(:tipo_rol_juez)
    end
end
