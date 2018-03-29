class PersonasController < ApplicationController
  before_action :set_persona, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /personas
  # GET /personas.json
  def index
  end

  def lista
    @personas = []
    @personas = Persona.por_nombre(params[:buscar]) unless params[:buscar].blank?
    render 'personas', layout: false
  end

  def guardar_seguimiento
    begin
      id = 0
      result = true
      mensaje = 'Guardado correctamente'
      nota = PersonaNotaSeguimiento.new
      nota.fecha = Date.today
      nota.usuario_id = current_usuario.id
      nota.persona_id = params[:persona_id]
      nota.notas = params[:nota]
      raise Util::Mensaje.mensajes_error_modelo(nota.errors) unless nota.save
      id = nota.id
    rescue StandardError => e
      result = false
      mensaje = 'Error al eliminar: ' + Util::Mensaje.limpiar_mensaje(e.message)
    ensure
      render json: { result: result, mensaje: mensaje, id: id }
    end
  end

  def obtener_nota
    @nota = PersonaNotaSeguimiento.find(params[:id])
    render 'nota', layout: false
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
  end

  # GET /personas/new
  def new
    @persona = Persona.new
  end

  # GET /personas/1/edit
  def edit
  end

  # POST /personas
  # POST /personas.json
  def create
    @persona = Persona.new(persona_params)

    respond_to do |format|
      if @persona.save
        format.html { redirect_to @persona, notice: 'Persona creada correctamente.' }
        format.json { render :show, status: :created, location: @persona }
      else
        format.html { render :new }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas/1
  # PATCH/PUT /personas/1.json
  def update
    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to @persona, notice: 'Persona actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @persona }
      else
        format.html { render :edit }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.json
  def destroy
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to personas_url, notice: 'Persona eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def persona_params
      params.require(:persona).permit(:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :fecha_nacimiento, :direccion, :bautizado, :epp, :edl, :observacion, :telefono, :celular, :email, :seguimiento)
    end
end
