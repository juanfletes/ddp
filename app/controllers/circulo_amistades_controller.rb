# encoding: utf-8

class CirculoAmistadesController < ApplicationController
  before_action :set_circulo_amistad, only: [:show, :edit, :update, :destroy]

  # GET /circulo_amistades
  # GET /circulo_amistades.json
  def index
    @circulo_amistades = CirculoAmistad.all
  end

  # GET /circulo_amistades/1
  # GET /circulo_amistades/1.json
  def show
  end

  # GET /circulo_amistades/new
  def new
    @circulo_amistad = CirculoAmistad.new
  end

  # GET /circulo_amistades/1/edit
  def edit
  end

  # POST /circulo_amistades
  # POST /circulo_amistades.json
  def create
    @circulo_amistad = CirculoAmistad.new(circulo_amistad_params)

    respond_to do |format|
      if @circulo_amistad.save
        format.html { redirect_to @circulo_amistad, notice: 'Circulo amistad was successfully created.' }
        format.json { render :show, status: :created, location: @circulo_amistad }
      else
        format.html { render :new }
        format.json { render json: @circulo_amistad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /circulo_amistades/1
  # PATCH/PUT /circulo_amistades/1.json
  def update
    respond_to do |format|
      if @circulo_amistad.update(circulo_amistad_params)
        format.html { redirect_to @circulo_amistad, notice: 'Circulo amistad was successfully updated.' }
        format.json { render :show, status: :ok, location: @circulo_amistad }
      else
        format.html { render :edit }
        format.json { render json: @circulo_amistad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /circulo_amistades/1
  # DELETE /circulo_amistades/1.json
  def destroy
    @circulo_amistad.destroy
    respond_to do |format|
      format.html { redirect_to circulo_amistades_url, notice: 'Circulo amistad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circulo_amistad
      @circulo_amistad = CirculoAmistad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circulo_amistad_params
      params.require(:circulo_amistad).permit(:nombre, :direccion, :horario, :pasivo)
    end
end
