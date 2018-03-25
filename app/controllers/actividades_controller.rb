# encoding: utf-8

class ActividadesController < ApplicationController
  before_action :set_actividad, only: [:show, :edit, :update, :destroy]

  # GET /actividades
  # GET /actividades.json
  def index
    @buscar = params[:buscar]
    @tipo = params[:tipo]
    @actividades = @buscar.blank? ? Actividad.order('fecha desc') : Actividad.buscar(@buscar)
    @actividades = @actividades.where(tipo: @tipo.to_i) unless @tipo.blank?
  end

  def matrimonios
    @actividad = Actividad.find(params[:actividad_id])
    @matrimonios = if params[:buscar].blank?
                     Matrimonio.joins(:actividades).where( integrante_actividades: { actividad_id: @actividad.id})
                   else
                     Matrimonio.buscar(params[:buscar])
                   end

    render 'matrimonios', layout: false
  end

  def agregar_quitar_participante
    result = true
    mensaje = ''
    begin
      actividad = Actividad.find(params[:actividad_id])
      integrante = IntegranteActividad.where(actividad_id: params[:actividad_id],
                                             matrimonio_id: params[:matrimonio_id]).first
      if integrante.nil?
        integrante = IntegranteActividad.new
        integrante.actividad_id = params[:actividad_id]
        integrante.matrimonio_id = params[:matrimonio_id]
        raise Util::Mensaje.mensajes_error_modelo(integrante.errors) unless integrante.save
        mensaje = 'Agregardo Correctamente'
      else
        raise Util::Mensaje.mensajes_error_modelo(integrante.errors) unless integrante.destroy
        mensaje = 'Eliminado Correctamente'
      end
    rescue StandardError => e
      result = false
      mensaje = Util::Mensaje.limpiar_mensaje(e.message)
    ensure
      render json: { result: result,
                     mensaje: mensaje,
                     cantidad_integrantes: actividad.cantidad_integrantes }
    end
  end

  # GET /actividades/1
  # GET /actividades/1.json
  def show
  end

  # GET /actividades/new
  def new
    @actividad = Actividad.new
  end

  # GET /actividades/1/edit
  def edit
  end

  # POST /actividades
  # POST /actividades.json
  def create
    @actividad = Actividad.new(actividad_params)

    respond_to do |format|
      if @actividad.save
        format.html { redirect_to @actividad, notice: 'Creado correctamente.' }
        format.json { render :show, status: :created, location: @actividad }
      else
        format.html { render :new }
        format.json { render json: @actividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actividades/1
  # PATCH/PUT /actividades/1.json
  def update
    respond_to do |format|
      if @actividad.update(actividad_params)
        format.html { redirect_to @actividad, notice: 'Actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @actividad }
      else
        format.html { render :edit }
        format.json { render json: @actividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividades/1
  # DELETE /actividades/1.json
  def destroy
    @actividad.destroy
    respond_to do |format|
      format.html { redirect_to actividades_url, notice: 'Borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actividad
      @actividad = Actividad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actividad_params
      params.require(:actividad).permit(:nombre, :fecha, :objetivo, :reporte, :tipo, :observacion)
    end
end
