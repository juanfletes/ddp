class PersonasNotaSeguimientoController < ApplicationController
  before_action :set_persona_nota_seguimiento, only: [:edit, :update, :destroy]

  # GET /personas_nota_seguimiento/new
  def new
    @persona = Persona.find(params[:persona_id])
    @persona_nota_seguimiento = PersonaNotaSeguimiento.new
  end

  # GET /personas_nota_seguimiento/1/edit
  def edit
  end

  # POST /personas_nota_seguimiento
  # POST /personas_nota_seguimiento.json
  def create
    @persona = Persona.find(params[:persona_id])
    @persona_nota_seguimiento = PersonaNotaSeguimiento.new(persona_nota_seguimiento_params)
    @persona_nota_seguimiento.persona = @persona
    @persona_nota_seguimiento.usuario = current_usuario
    if @persona_nota_seguimiento.save
      redirect_to @persona, notice: 'Guardado Correctamente.'
    else
      render :new
    end
  end

  # PATCH/PUT /personas_nota_seguimiento/1
  # PATCH/PUT /personas_nota_seguimiento/1.json
  def update
    if @persona_nota_seguimiento.update(persona_nota_seguimiento_params)
      redirect_to @persona, notice: 'Actualizado Correctamente.'
    else
      render :edit
    end
  end

  # DELETE /personas_nota_seguimiento/1
  # DELETE /personas_nota_seguimiento/1.json
  def destroy
    if @persona_nota_seguimiento.destroy
      redirect_to @persona, notice: 'Eliminado Correctamente.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona_nota_seguimiento
      @persona_nota_seguimiento = PersonaNotaSeguimiento.find(params[:id])
      @persona = @persona_nota_seguimiento.persona
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def persona_nota_seguimiento_params
      params.require(:persona_nota_seguimiento).permit(:fecha, :notas)
    end
end
