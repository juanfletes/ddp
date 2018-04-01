# encoding: utf-8

class MatrimoniosController < ApplicationController
  before_action :set_matrimonio, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /matrimonios
  # GET /matrimonios.json
  def index
    @buscar = params[:buscar]
  end

  def lista
    @matrimonios = []
    @matrimonios = Matrimonio.buscar(params[:buscar]) unless params[:buscar].blank?
    render 'matrimonios', layout: false
  end

  # GET /matrimonios/1
  # GET /matrimonios/1.json
  def show
    @actividades = Actividad.joins(:integrantes)
                            .where(integrante_actividades: { matrimonio_id: @matrimonio.id })
                            .order(fecha: :desc)
  end

  # GET /matrimonios/new
  def new
    @matrimonio = Matrimonio.new
  end

  # GET /matrimonios/1/edit
  def edit
  end

  # POST /matrimonios
  # POST /matrimonios.json
  def create
    begin
      ActiveRecord::Base.transaction do
        @el = Persona.new(el_params)
        @ella = Persona.new(ella_params)

        raise Util::Mensaje.mensajes_error_modelo(@el.errors) unless @el.save
        raise Util::Mensaje.mensajes_error_modelo(@ella.errors) unless @ella.save

        @matrimonio = Matrimonio.new(matrimonio_params)
        @matrimonio.esposo_id = @el.id
        @matrimonio.esposa_id = @ella.id
        unless @matrimonio.save
          raise Util::Mensaje.mensajes_error_modelo(@matrimonio.errors)
        end

        flash[:notice] = 'Registrado correctamente'
        redirect_to '/matrimonios/' + @matrimonio.id.to_s + '/edit'
      end
    rescue StandardError => e
      flash[:alert] = 'Error al registrar: ' + Util::Mensaje.limpiar_mensaje(e.message)
      render 'new'
    end
  end

  # PATCH/PUT /matrimonios/1
  # PATCH/PUT /matrimonios/1.json
  def update
    begin
      ActiveRecord::Base.transaction do
        @matrimonio = Matrimonio.find(params[:id])
        @matrimonio.boda_civil = !params[:matrimonio][:boda_civil].blank?
        @matrimonio.boda_eclesiastica = !params[:matrimonio][:boda_eclesiastica].blank?
        @matrimonio.observacion = params[:matrimonio][:observacion]

        @el = @matrimonio.esposo
        @el.attributes = el_params
        @el.bautizado = !params[:el][:bautizado].blank?
        @el.epp = !params[:el][:epp].blank?
        @el.edl = !params[:el][:edl].blank?
        @el.seguimiento = !params[:el][:seguimiento].blank?

        @ella = @matrimonio.esposa
        @ella.attributes = ella_params
        @ella.bautizado = !params[:ella][:bautizado].blank?
        @ella.epp = !params[:ella][:epp].blank?
        @ella.edl = !params[:ella][:edl].blank?
        @ella.seguimiento = !params[:ella][:seguimiento].blank?

        raise Util::Mensaje.mensajes_error_modelo(@matrimonio.errors) unless @matrimonio.save
        raise Util::Mensaje.mensajes_error_modelo(@el.errors) unless @el.save
        raise Util::Mensaje.mensajes_error_modelo(@ella.errors) unless @ella.save

        flash[:notice] = 'Actualizado correctamente'
      end
    rescue StandardError => e
      flash[:alert] = 'Error al actualizar: ' + Util::Mensaje.limpiar_mensaje(e.message)
    ensure
      redirect_to '/matrimonios/' + @matrimonio.id.to_s + '/edit'
    end
  end

  # DELETE /matrimonios/1
  # DELETE /matrimonios/1.json
  def destroy
    begin
      result = true
      mensaje = 'Eliminado correctamente'
      raise Util::Mensaje.mensajes_error_modelo(@matrimonio.errors) unless @matrimonio.destroy
    rescue StandardError => e
      result = false
      mensaje = 'Error al eliminar: ' + Util::Mensaje.limpiar_mensaje(e.message)
    ensure
      render json: { result: result, mensaje: mensaje }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_matrimonio
    @matrimonio = Matrimonio.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def matrimonio_params
    params.require(:matrimonio).permit(:esposo_id,
                                       :esposa_id,
                                       :boda_civil,
                                       :boda_eclesiastica,
                                       :observacion)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def el_params
    params.require(:el).permit(:primer_nombre,
                               :segundo_nombre,
                               :primer_apellido,
                               :segundo_apellido,
                               :telefono,
                               :sexo,
                               :celular,
                               :email,
                               :bautizado,
                               :epp,
                               :edl,
                               :observacion,
                               :direccion)
  end

  def ella_params
    params.require(:ella).permit(:primer_nombre,
                                 :segundo_nombre,
                                 :primer_apellido,
                                 :segundo_apellido,
                                 :telefono,
                                 :sexo,
                                 :celular,
                                 :email,
                                 :bautizado,
                                 :epp,
                                 :edl,
                                 :observacion,
                                 :direccion)
  end
end
