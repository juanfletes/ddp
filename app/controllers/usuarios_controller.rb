class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :lista_personas, only: [:show, :edit, :new]
  check_authorization
  load_and_authorize_resource

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all.order('primer_nombre, primer_apellido')
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  def asignaciones_seguimiento
    @usuario = Usuario.find(params[:usuario_id])
    @personas = if params[:buscar].blank?
                  Persona.joins(:asignado_a).where(asignaciones_seguimiento: { usuario_id: @usuario.id })
                else
                  Persona.por_nombre(params[:buscar])
                end

    render 'personas', layout: false
  end

  def agregar_seguimiento
    result = true
    mensaje = ''
    usuario = Usuario.find(params[:usuario_id])
    begin
      ActiveRecord::Base.transaction do
        persona = Persona.find(params[:persona_id])
        usuario_persona = usuario.persona
        persona_matrimonio = persona.obtener_matrimonio

        asignacion_usuario_actual = AsignacionSeguimiento.new
        asignacion_usuario_actual.usuario_id = usuario.id
        asignacion_usuario_actual.persona_id = if persona.tiene_matrimonio?
                                                 usuario.sexo == 'M' ? persona_matrimonio.esposo_id : persona_matrimonio.esposa_id
                                               else
                                                 persona.id
                                               end
        raise Util::Mensaje.mensajes_error_modelo(asignacion_usuario_actual.errors) unless asignacion_usuario_actual.save

        if usuario_persona.present? && usuario_persona.tiene_matrimonio? && persona.tiene_matrimonio?
          usuario_matrimonio = usuario_persona.obtener_matrimonio
          usuario_masculino = Usuario.where(persona_id: usuario_matrimonio.esposo_id).first
          usuario_femenino = Usuario.where(persona_id: usuario_matrimonio.esposa_id).first
          usuario_conyuge = usuario.id = usuario_matrimonio.esposo_id ? usuario_femenino : usuario_masculino
          if usuario_conyuge.present?
            asignacion_usuario_conyuge = AsignacionSeguimiento.new
            asignacion_usuario_conyuge.usuario_id = usuario_conyuge.id
            asignacion_usuario_conyuge.persona_id = usuario_conyuge.sexo == 'M' ? persona_matrimonio.esposo_id : persona_matrimonio.esposa_id
            raise Util::Mensaje.mensajes_error_modelo(asignacion_usuario_conyuge.errors) unless asignacion_usuario_conyuge.save
          end
        end
        mensaje = 'Agregardo Correctamente'
      end
    rescue StandardError => e
      result = false
      mensaje = Util::Mensaje.limpiar_mensaje(e.message)
    ensure
      render json: { result: result,
                     mensaje: mensaje,
                     cantidad_personas: usuario.cantidad_personas_asignadas }
    end
  end

  def quitar_seguimiento
    result = true
    mensaje = ''
    usuario = Usuario.find(params[:usuario_id])
    begin
      ActiveRecord::Base.transaction do
        persona = Persona.find(params[:persona_id])
        usuario_persona = usuario.persona
        persona_matrimonio = persona.obtener_matrimonio

        asignacion_usuario_actual = AsignacionSeguimiento.where(usuario_id: usuario.id, persona_id: persona.id).first
        raise Util::Mensaje.mensajes_error_modelo(asignacion_usuario_actual.errors) unless asignacion_usuario_actual.destroy

        if !usuario_persona.blank? && usuario_persona.tiene_matrimonio? && persona.tiene_matrimonio?
          usuario_matrimonio = usuario_persona.obtener_matrimonio
          usuario_masculino = Usuario.where(persona_id: usuario_matrimonio.esposo_id).first
          usuario_femenino = Usuario.where(persona_id: usuario_matrimonio.esposa_id).first
          usuario_conyuge = usuario.id = usuario_matrimonio.esposo_id ? usuario_femenino : usuario_masculino
          persona_conyuge_id = usuario_conyuge.sexo == 'M' ? persona_matrimonio.esposo_id : persona_matrimonio.esposa_id
          asignacion_usuario_conyuge = AsignacionSeguimiento.where(usuario_id: usuario_conyuge.id, persona_id: persona_conyuge_id).first
          if asignacion_usuario_conyuge.present?
            raise Util::Mensaje.mensajes_error_modelo(asignacion_usuario_conyuge.errors) unless asignacion_usuario_conyuge.destroy
          end
        end
        mensaje = 'Eliminado Correctamente'
      end
    rescue StandardError => e
      result = false
      mensaje = Util::Mensaje.limpiar_mensaje(e.message)
    ensure
      render json: { result: result,
                     mensaje: mensaje,
                     cantidad_personas: usuario.cantidad_personas_asignadas }
    end
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params_create)

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to edit_usuario_path(@usuario), notice: 'Guardado Correctamente' }
        format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    respond_to do |format|
      if @usuario.update(usuario_params_update)
        format.html { redirect_to edit_usuario_path(@usuario), notice: 'Guardado Correctamente' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def actualizar_clave
    @usuario = Usuario.find(params[:usuario_id].to_i)
    begin
      raise 'Ingrese la Clave' if params[:password].blank?
      raise 'Clave Incorrecta' unless @usuario.valid_password?(params[:current_password])
      unless @usuario.update_attributes(password: params[:password],
                                        password_confirmation: params[:password_confirmation])

        mensaje = ''
        @usuario.errors.full_messages.each do |message|
          mensaje += message
        end
        raise mensaje
      end
      redirect_to edit_usuario_path(@usuario), notice: 'Clave actualizada Correctamente'
    rescue StandardError => e
      redirect_to edit_usuario_path(@usuario), alert: 'Error al actualizar clave ' + e.message
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Eliminado Correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_usuario
    @usuario = Usuario.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def usuario_params_create
    params.require(:usuario).permit(:email, :primer_nombre, :segundo_nombre,
                                    :primer_apellido, :segundo_apellido, :password, :persona_id)
  end

  def usuario_params_update
    params.require(:usuario).permit(:email, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido,
                                    :persona_id)
  end

  def lista_personas
    @personas = Persona.order(:primer_nombre, :primer_apellido)
  end

end
