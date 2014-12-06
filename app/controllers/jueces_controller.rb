class JuecesController < ApplicationController
  before_action :set_juece, only: [:show, :edit, :update, :destroy]

  # GET /jueces
  # GET /jueces.json
  def index
    @jueces = Juece.all
  end

  # GET /jueces/1
  # GET /jueces/1.json
  def show
  end

  # GET /jueces/new
  def new
    @juece = Juece.new
  end

  # GET /jueces/1/edit
  def edit
  end

  # POST /jueces
  # POST /jueces.json
  def create
    @juece = Juece.new(juece_params)

    respond_to do |format|
      if @juece.save
        format.html { redirect_to @juece, notice: 'Juece was successfully created.' }
        format.json { render :show, status: :created, location: @juece }
      else
        format.html { render :new }
        format.json { render json: @juece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jueces/1
  # PATCH/PUT /jueces/1.json
  def update
    respond_to do |format|
      if @juece.update(juece_params)
        format.html { redirect_to @juece, notice: 'Juece was successfully updated.' }
        format.json { render :show, status: :ok, location: @juece }
      else
        format.html { render :edit }
        format.json { render json: @juece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jueces/1
  # DELETE /jueces/1.json
  def destroy
    @juece.destroy
    respond_to do |format|
      format.html { redirect_to jueces_url, notice: 'Juece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_juece
      @juece = Juece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def juece_params
      params.require(:juece).permit(:nombre_juez, :apellido_pat_juez, :apellido_mat_juez, :rut_juez, :sexo_juez, :fecha_nac_juez, :email_juez, :foto_juez)
    end
end
