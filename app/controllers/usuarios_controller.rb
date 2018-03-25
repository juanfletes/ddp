class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

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
end
